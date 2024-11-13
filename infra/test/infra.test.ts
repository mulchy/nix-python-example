import * as cdk from "aws-cdk-lib";
import { Template } from "aws-cdk-lib/assertions";
import * as Infra from "../lib/infra-stack";

test("Function Created", () => {
  const app = new cdk.App();
  const stack = new Infra.InfraStack(app, "MyTestStack");
  const template = Template.fromStack(stack);

  // add some assertions here
  template.hasResourceProperties("AWS::Lambda::Function", {});
});
