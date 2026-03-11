## Terraform State Management

### Overview
Terraform state files track all infrastructure resources managed by Terraform. 
State files are stored locally and excluded from version control for security reasons.

### State File Locations
Each workspace maintains its own state file:
- Dev: `terraform/terraform.tfstate.d/dev/terraform.tfstate`
- Staging: `terraform/terraform.tfstate.d/staging/terraform.tfstate`
- Prod: `terraform/terraform.tfstate.d/prod/terraform.tfstate`

### Backup Procedures
Always back up state files before performing destructive operations 
(terraform destroy, major infrastructure changes).

**Manual backup:**
```bash
cp terraform/terraform.tfstate.d/dev/terraform.tfstate \
   terraform/terraform.tfstate.d/dev/terraform.tfstate.backup.$(date +%Y%m%d)
```

**Before any destructive operation:**
1. Back up all workspace state files
2. Verify backup was created successfully
3. Proceed with the operation
4. Keep backups for at least 30 days

### Restoring from Backup
If state becomes corrupted:
```bash
cp terraform/terraform.tfstate.d/dev/terraform.tfstate.backup.YYYYMMDD \
   terraform/terraform.tfstate.d/dev/terraform.tfstate
terraform refresh -var-file=envs/dev.tfvars
```

### Important Notes
- Never delete state files without a backup
- Never commit state files to version control — they may contain sensitive values
- If state is lost, use `terraform import` to re-associate resources with state

## Kubernetes Deployment Strategy

### Rolling Updates
This project uses Kubernetes Rolling Update strategy for all deployments.

**Configuration applied to all services:**
```yaml
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1
    maxUnavailable: 0
```

**How it works:**
1. Kubernetes spins up 1 new pod with the updated image (maxSurge: 1)
2. Waits for the new pod to pass health checks and become Ready
3. Terminates 1 old pod (maxUnavailable: 0 ensures no downtime)
4. Repeats until all pods are updated

**Why Rolling Updates over alternatives:**
- **vs Blue-Green**: Blue-green requires double the resources to run two 
  full environments simultaneously. Not practical for local development.
- **vs Canary**: Canary deployments require additional traffic routing 
  infrastructure. Rolling updates achieve similar safety with less complexity.
- **Zero downtime**: maxUnavailable: 0 guarantees at least one pod is always 
  serving traffic during updates.
- **Automatic rollback**: If the new pod fails to start, Kubernetes stops 
  the rollout and the old pods continue serving traffic.

### Rollback Procedure
To roll back to a previous version:
```bash
kubectl rollout undo deployment/<service-name> -n ecommerce-dev
```

To roll back to a specific revision:
```bash
kubectl rollout history deployment/<service-name> -n ecommerce-dev
kubectl rollout undo deployment/<service-name> --to-revision=<number> -n ecommerce-dev
```