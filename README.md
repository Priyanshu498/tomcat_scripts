# Deployment strategies | Canary
https://www.google.com/url?sa=i&url=https%3A%2F%2Fthinksys.com%2Fdevelopment%2Fcanary-deployment%2F&psig=AOvVaw0tIWdQy-I9ZICb-Vn72J7P&ust=1737028426246000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCOjD4KfV94oDFQAAAAAdAAAAABAE

## Author

| Created/Updated | Version  | Author | Comment |           
|:---------------:|:--------:|:------:|:-------:|
|15-01-2025      | 1.0      | Priyanshu Yadav  | Initial Documentation |

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [How It Works](#how-it-works)
- [Advantages of Canary Deployment](#advantages-of-canary-deployment)
- [Disadvantages of Canary Deployment](#disadvantages-of-canary-deployment)
- [Best Practices](#best-practices)
- [Tools for Canary Deployment](#tools-for-canary-deployment)
- [Example Scenario](#example-scenario)
- [Why Should We Use It in Our Project](#why-should-we-use-it-in-our-project)
- [Conclusion](#conclusion)
- [Contact Information](#contact-information)
- [References](#references)

## Introduction
In this document, I have explained canary deployment, a technique designed to reduce the risk of deploying new software versions by gradually rolling out changes to a subset of users before full deployment. This approach allows for early detection of issues without impacting the entire user base.

## Getting Started
To implement canary deployment, you need to have the capability to route a portion of your traffic to the new version of your application while the rest continues to use the existing version. This phased rollout helps in monitoring the impact of the new version on a small group of users before wider release.

## How It Works
1. **Incremental Rollout**: Start by deploying the new version to a small subset of users.
2. **Monitor and Analyze**: Continuously monitor the performance and gather feedback.
3. **Gradual Increase**: If no issues are detected, gradually increase the number of users directed to the new version.
4. **Full Deployment**: Once confidence is gained, roll out the new version to all users.

## Advantages of Canary Deployment

| Advantage           | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| **Reduced Risk**    | Gradual rollout minimizes the risk of widespread issues.                    |
| **Early Detection** | Early detection of bugs or issues in the new version.                       |
| **User Feedback**   | Collect feedback from real users before full deployment.                    |

## Disadvantages of Canary Deployment

| Disadvantage         | Description                                                                     |
|----------------------|---------------------------------------------------------------------------------|
| **Complex Routing**  | Requires sophisticated routing and traffic management.                         |
| **Resource Requirements** | Need resources to support running multiple versions.                        |
| **Monitoring Overhead**   | Requires robust monitoring and analysis tools.                              |
## Flow chart
graph TD
    A[Develop Infrastructure Code] --> B[Build Artifacts (AMIs/Images)]
    B --> C[Test in Staging Environment]
    C --> D[Canary Deployment to Small Subset]
    D --> E[Monitor Metrics]
    E --> F[Validate Results]
    F -- Success --> G[Gradual Rollout (25% -> 50% -> 100%)]
    F -- Failure --> H[Rollback to Last Stable Infra]
    G --> I[Decommission Old Infrastructure]
## Best Practices
- **Automate Rollouts**: Use automation tools to manage the incremental rollout.
- **Real-Time Monitoring**: Continuously monitor the performance and gather user feedback.
- **Gradual Increase**: Gradually increase the user base exposed to the new version to catch issues early.

## Tools for Canary Deployment
- **Kubernetes**: Supports canary deployments using service meshes like Istio or Linkerd.
- **AWS CodeDeploy**: Supports canary deployment strategies.
- **Spinnaker**: A continuous delivery tool that supports canary deployments.
- **Feature Flagging Tools**: LaunchDarkly, Flagsmith for controlling feature rollouts.

## Example Scenario
**E-commerce Application**:
- **Initial Rollout**: Deploy new feature to 5% of users.
- **Monitoring**: Monitor for performance and errors.
- **Feedback Collection**: Gather user feedback.
- **Gradual Rollout**: Increase to 25%, 50%, and finally 100% of users if no issues are detected.
- **Rollback**: Quickly rollback if issues are detected at any stage.

## Why Should We Use It in Our Project
Using canary deployment in our project will:
- **Minimize Risk**: Reduce the impact of potential issues by limiting exposure.
- **Enhance Stability**: Detect and resolve issues early, improving overall application stability.
- **Improve User Experience**: Roll out new features with minimal disruption to users.

## Conclusion
Canary deployment is a valuable strategy for managing the release of new software versions. By gradually exposing the new version to a subset of users, it allows for early detection of issues and minimizes the risk associated with full-scale deployments.

## Contact Information

| Name | Email address | 
|--------|------------|
| Priyanshu Yadav | priyanshu.yadav.snaatak@mygurukulam.co  |

## References
- [Martin Fowler on Canary Release](https://martinfowler.com/bliki/CanaryRelease.html)
- [AWS Documentation on Canary Deployments](https://docs.aws.amazon.com/codedeploy/latest/userguide/deployment-steps-canary.html)
- [Kubernetes Canary Deployment](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/#canary-deployments)
