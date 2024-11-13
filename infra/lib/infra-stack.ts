import * as cdk from "aws-cdk-lib";
import { Construct } from "constructs";
import * as lambda from "aws-cdk-lib/aws-lambda";
import * as logs from "aws-cdk-lib/aws-logs";
import * as iam from "aws-cdk-lib/aws-iam";
// import * as ec2 from "aws-cdk-lib/aws-ec2";
import { Platform } from "aws-cdk-lib/aws-ecr-assets";
import path = require("path");

export class InfraStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const func = new lambda.DockerImageFunction(this, "MyFunction", {
      timeout: cdk.Duration.seconds(60),
      architecture: lambda.Architecture.ARM_64,
      code: lambda.DockerImageCode.fromImageAsset(
        path.join(__dirname, "../.build/ecr"),
        {
          exclude: ["cdk.out"],
          platform: Platform.LINUX_ARM64,
        },
      ),
      logGroup: new logs.LogGroup(this, "MyLogGroup", {
        retention: logs.RetentionDays.TWO_WEEKS,
        removalPolicy: cdk.RemovalPolicy.DESTROY,
      }),
      role: new iam.Role(this, "MyRole", {
        assumedBy: new iam.ServicePrincipal("lambda.amazonaws.com"),
      }),
      // vpc: ec2.Vpc.fromLookup(this, "MyVpc", {
      //   vpcId: "vpc-1234567890",
      // }),
    });

    func.applyRemovalPolicy(cdk.RemovalPolicy.DESTROY);
  }
}
