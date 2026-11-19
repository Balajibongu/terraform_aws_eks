# Terraform AWS Security Group Destroy – Troubleshooting Guide

## 1. Problem Statement

While working on an AWS EKS Terraform project, I initially created multiple AWS Security Groups using Terraform.

During the process, I accidentally deleted a few Security Groups manually from AWS and subsequently executed:

```bash
terraform apply
terraform destroy
```

However, Terraform got stuck while destroying the Security Groups.

The terminal continuously displayed:

```text
module.security_group[7].aws_security_group.main:
Still destroying...

module.security_group[5].aws_security_group.main:
Still destroying...

module.security_group[4].aws_security_group.main:
Still destroying...

module.security_group[8].aws_security_group.main:
Still destroying...
```

## 2. Initial Investigation

### Step 1: Check Terraform state

Executed:

```bash
terraform state list
```

Initially, Terraform showed only five Security Group resources:

```text
module.security_group[0].aws_security_group.main
module.security_group[1].aws_security_group.main
module.security_group[2].aws_security_group.main
module.security_group[3].aws_security_group.main
module.security_group[6].aws_security_group.main
```

The following resources were missing:

- module.security_group[4]
- module.security_group[5]
- module.security_group[7]
- module.security_group[8]

### Step 2: Check existing AWS Security Groups

Executed:

```bash
aws ec2 describe-security-groups \
  --filters Name=vpc-id,Values=vpc-036f0663b0053653f \
  --query "SecurityGroups[*].[GroupId,GroupName]" \
  --output table
```

AWS showed that the Security Groups still existed.

| Security Group | Security Group ID |
|---|---|
| bastion | sg-06b3c478c467821a9 |
| ingress_alb | sg-008508c627cc2cd1b |
| eks_control_plane | sg-07ba9d92bd6b394f1 |
| eks_node | sg-04e46bfa6e7f7a1e7 |

This revealed a mismatch between Terraform state and actual AWS resources.

## 3. Solution 1: Import Missing Security Groups

Since the Security Groups existed in AWS but were missing from Terraform state, I imported them.

```bash
terraform import 'module.security_group[4].aws_security_group.main' sg-06b3c478c467821a9

terraform import 'module.security_group[5].aws_security_group.main' sg-008508c627cc2cd1b

terraform import 'module.security_group[7].aws_security_group.main' sg-07ba9d92bd6b394f1

terraform import 'module.security_group[8].aws_security_group.main' sg-04e46bfa6e7f7a1e7
```

All four imports were successful.

Verified using:

```bash
terraform state list
```

Now Terraform displayed all nine Security Group resources.

**Learning:** Terraform import brings an existing AWS resource under Terraform state management. It does not create a new AWS resource.

## 4. Solution 2: Investigate AWS Dependencies

Even after importing the missing Security Groups, Terraform continued displaying:

```text
Still destroying...
```

I investigated whether the Security Groups were attached to Elastic Network Interfaces (ENIs).

Executed:

```bash
aws ec2 describe-network-interfaces \
  --filters Name=group-id,Values=sg-06b3c478c467821a9
```

Repeated this for the other three Security Groups.

No ENIs were returned by the queries.

This suggested that ENI attachments were not the immediate cause.

## 5. Solution 3: Identify Security Group References

Next, I investigated whether one Security Group was referencing another.

Executed:

```bash
aws ec2 describe-security-group-rules \
  --region us-east-1 \
  --query "SecurityGroupRules[?ReferencedGroupInfo.GroupId=='sg-06b3c478e4']" \
  --output table
```

The final investigation identified five blocking ingress rules.

### Identified dependencies

| Rule ID | Owning Security Group | Referenced Security Group |
|---|---|---|
| sgr-067d7b01154aa5914 | eks_control_plane | bastion |
| sgr-0a320322b459452b6 | eks_node | bastion |
| sgr-00df2ef68ea803766 | eks_control_plane | ingress_alb |
| sgr-02de369d48758a803 | eks_node | eks_control_plane |
| sgr-05bc4188937e8f722 | eks_control_plane | eks_node |

The last two rules created mutual references between the EKS control plane and worker node Security Groups.

**Root cause:** AWS security group dependencies prevented the referenced security groups from being deleted.

## 6. Solution 4: Remove Blocking Ingress Rules

All five identified rules were ingress rules.

I used the following AWS CLI command to revoke each rule.

### Rule 1: Remove bastion reference from eks_control_plane

```bash
aws ec2 revoke-security-group-ingress \
  --region us-east-1 \
  --group-id sg-07ba9d92bd6b394f1 \
  --security-group-rule-ids sgr-067d7b01154aa5914
```

### Rule 2: Remove bastion reference from eks_node

```bash
aws ec2 revoke-security-group-ingress \
  --region us-east-1 \
  --group-id sg-04e46bfa6e7f7a1e7 \
  --security-group-rule-ids sgr-0a320322b459452b6
```

### Rule 3: Remove ingress_alb reference from eks_control_plane

```bash
aws ec2 revoke-security-group-ingress \
  --region us-east-1 \
  --group-id sg-07ba9d92bd6b394f1 \
  --security-group-rule-ids sgr-00df2ef68ea803766
```

### Rule 4: Remove eks_node reference from eks_control_plane

```bash
aws ec2 revoke-security-group-ingress \
  --region us-east-1 \
  --group-id sg-07ba9d92bd6b394f1 \
  --security-group-rule-ids sgr-05bc4188937e8f722
```

### Rule 5: Remove eks_control_plane reference from eks_node

```bash
aws ec2 revoke-security-group-ingress \
  --region us-east-1 \
  --group-id sg-04e46bfa6e7f7a1e7 \
  --security-group-rule-ids sgr-02de369d48758a803
```

Note: These commands modify AWS network access. They should only be executed when the rules are no longer required.

## 7. Verify Security Group References

After revoking the rules, verify that the references are removed.

```bash
aws ec2 describe-security-group-rules \
  --region us-east-1 \
  --query "SecurityGroupRules[?ReferencedGroupInfo.GroupId=='sg-06b3c478c467821a9' || ReferencedGroupInfo.GroupId=='sg-008508c627cc2cd1b' || ReferencedGroupInfo.GroupId=='sg-07ba9d92bd6b394f1' || ReferencedGroupInfo.GroupId=='sg-04e46bfa6e7f7a1e7'].[GroupId,SecurityGroupRuleId,ReferencedGroupInfo.GroupId]" \
  --output table
```

The five identified rules should no longer appear.

## 8. Final Step: Execute Terraform Destroy

Before destroying resources, create a Terraform state backup:

```bash
terraform state pull > terraform-state-backup.json
```

Review the destroy plan:

```bash
terraform plan -destroy
```

If the plan contains only the intended resources, execute:

```bash
terraform destroy
```

Confirm with:

```text
yes
```

Finally, verify Terraform state:

```bash
terraform state list
```

Also verify AWS resources:

```bash
aws ec2 describe-security-groups \
  --region us-east-1 \
  --filters Name=vpc-id,Values=vpc-036f0663b0053653f \
  --query "SecurityGroups[*].[GroupId,GroupName]" \
  --output table
```

The AWS default Security Group will remain because AWS does not allow its deletion.

**Note:** If Terraform still gets stuck, investigate any remaining security group references or ENI attachments before attempting another deletion.

## 9. Important DevOps Learnings

1. Terraform state and actual AWS infrastructure must remain synchronized.
2. Avoid manually deleting Terraform-managed resources from AWS.
3. Use `terraform import` when existing resources need to be brought under Terraform management.
4. AWS Security Groups can reference other Security Groups through ingress and egress rules.
5. Circular Security Group references can complicate resource destruction.
6. Always investigate ENI dependencies before deleting Security Groups.
7. Use `terraform plan -destroy` before executing `terraform destroy`.
8. Always back up Terraform state before performing recovery operations.
9. Never use `terraform state rm` as a substitute for deleting an AWS resource.
10. Remove only the rules and dependencies that are safe to remove.

## 10. Conclusion

The issue started because Terraform state and AWS infrastructure became inconsistent after manually deleting some Security Groups.

Importing the missing resources corrected the state mismatch.

Further investigation revealed five Security Group ingress references that prevented AWS from deleting the groups.

The solution was to identify the exact rule IDs and revoke the unnecessary references before retrying Terraform destruction.

**Key takeaway: Before troubleshooting a stuck Terraform destroy operation, investigate Terraform state, AWS resource dependencies, ENI attachments, and Security Group references.**

---

**Technology Stack:** Terraform | AWS EC2 | AWS VPC | Security Groups | AWS CLI | Git Bash

**Project:** Terraform AWS EKS Infrastructure

**Troubleshooting Topic:** AWS Security Group Dependency Violation During Terraform Destroy