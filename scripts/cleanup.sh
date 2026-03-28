#!/bin/bash
echo "⚠️  WARNING: This will destroy all mia-ai-volt-streams infrastructure."
read -p "Are you sure? (y/n) " -n 1 -r
echo
if [[ \$REPLY =~ ^[Yy]\$ ]]
then
    echo "🧹 Tearing down Databricks and AWS PrivateLink and some..."
    cd terraform/environments/dev && terraform destroy -auto-approve
    echo "✅ Infrastructure removed."
fi