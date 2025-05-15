# Azure Data Factory with Private Storage Accounts

This Terraform project deploys an Azure Data Factory (ADF) solution with two virtual networks, each containing a private storage account with private endpoints. The ADF is configured to copy data between the two storage accounts.

## Components

1. **Azure Data Factory (ADF)**
   - Managed service for data integration and transformation
   - Configured with a pipeline to copy data between storage accounts

2. **Virtual Networks (VNets)**
   - Two separate VNets with non-overlapping address spaces
   - Each VNet has subnets for storage and private endpoints
   - Network Security Groups (NSGs) to control traffic

3. **Storage Accounts**
   - Two storage accounts with hierarchical namespace (ADLS Gen2)
   - Private endpoints for secure connectivity
   - Sample file in source storage for demonstration

4. **Private Endpoints**
   - Secure connections to storage accounts
   - Private DNS zones for name resolution

## Prerequisites

- Azure subscription
- Terraform v1.3.0 or later
- Azure CLI

## Deployment

1. Clone this repository
2. Navigate to the `ADF/Workload` directory
3. Update the `terraform.tfvars` file if needed
4. Initialize Terraform:
   ```
   terraform init
   ```
5. Create an execution plan:
   ```
   terraform plan -out=tfplan
   ```
6. Apply the plan:
   ```
   terraform apply tfplan
   ```

## Testing the Data Copy

After deployment:

1. Navigate to the Azure Portal
2. Open the Azure Data Factory
3. Go to "Author & Monitor"
4. Select the "PL_Copy_Data" pipeline
5. Click "Debug" to run the pipeline
6. Verify that the file has been copied to the destination storage account

## Best Practices Implemented

- **Security**:
  - Private endpoints for storage accounts
  - Network isolation with VNets and NSGs
  - Secure storage account configuration (HTTPS only, TLS 1.2)

- **Modularity**:
  - Reusable modules for VNets, storage accounts, and ADF
  - Parameterized configurations

- **Naming Conventions**:
  - Consistent naming across resources
  - Descriptive names for easy identification

- **Tagging**:
  - Comprehensive tagging for resource management
  - Environment, project, and cost center tags

## Clean Up

To remove all resources:

```
terraform destroy --auto-approve
```

## Contributing

Contributions to this project are welcome! Here's how you can contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Please make sure to update tests as appropriate and follow the coding standards.

## GitHub Integration

This project is configured for GitHub with:
- A comprehensive `.gitignore` file to prevent committing sensitive information
- Workflow suggestions for contributing
- Best practices for Terraform code management

## Notes

- Storage account names must be globally unique. You may need to modify them in `terraform.tfvars`.
- The deployment creates a sample file in the source storage account for demonstration purposes.
- For production use, consider enhancing security by using managed identities for ADF linked services instead of storage keys.
