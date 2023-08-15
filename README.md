[![Massdriver][logo]][website]

# mongodbatlas-cluster-aws

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

MongoDB Atlas allows you to run a fully managed MongoDB cluster alongside your other resources in AWS, offering low-latency, high-availability with minimal maintenance.

---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

<!-- COMPLIANCE:START -->

Security and compliance scanning of our bundles is performed using [Bridgecrew](https://www.bridgecrew.cloud/). Massdriver also offers security and compliance scanning of operational infrastructure configured and deployed using the platform.

| Benchmark                                                                                                                                                                                                                                                       | Description                        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [![Infrastructure Security](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/mongodbatlas-cluster-aws/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fmongodbatlas-cluster-aws&benchmark=INFRASTRUCTURE+SECURITY) | Infrastructure Security Compliance |
| [![PCI-DSS](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/mongodbatlas-cluster-aws/pci>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fmongodbatlas-cluster-aws&benchmark=PCI-DSS+V3.2) | Payment Card Industry Data Security Standards Compliance |
| [![NIST-800-53](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/mongodbatlas-cluster-aws/nist>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fmongodbatlas-cluster-aws&benchmark=NIST-800-53) | National Institute of Standards and Technology Compliance |
| [![ISO27001](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/mongodbatlas-cluster-aws/iso>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fmongodbatlas-cluster-aws&benchmark=ISO27001) | Information Security Management System, ISO/IEC 27001 Compliance |
| [![SOC2](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/mongodbatlas-cluster-aws/soc2>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fmongodbatlas-cluster-aws&benchmark=SOC2)| Service Organization Control 2 Compliance |
| [![HIPAA](https://www.bridgecrew.cloud/badges/github/massdriver-cloud/mongodbatlas-cluster-aws/hipaa>)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=massdriver-cloud%2Fmongodbatlas-cluster-aws&benchmark=HIPAA) | Health Insurance Portability and Accountability Compliance |

<!-- COMPLIANCE:END -->

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`backup`** *(object)*
  - **`enabled`** *(boolean)*: Enable scheduled [cluster backups](https://www.mongodb.com/docs/atlas/backup/cloud-backup/dedicated-cluster-backup/#dedicated-cluster-backups). Default: `True`.
- **`database`** *(object)*
  - **`autoscaling`** *(object)*
    - **`instance_size_max`** *(string)*: Must be one of: `['M10', 'M20', 'M30', 'M40', 'M50', 'M60', 'M80', 'M140', 'M200', 'M300', 'M400', 'M700']`. Default: `M40`.
    - **`instance_size_min`** *(string)*: Must be one of: `['M10', 'M20', 'M30', 'M40', 'M50', 'M60', 'M80', 'M140', 'M200', 'M300', 'M400', 'M700']`. Default: `M10`.
  - **`cluster_type`** *(string)*: Must be one of: `['REPLICASET', 'SHARDED']`. Default: `REPLICASET`.
  - **`electable_node_count`** *(integer)*: Must be one of: `[3, 5, 7]`. Default: `3`.
  - **`termination_protection_enabled`** *(boolean)*: Termination protection will protect the cluster from accidental termination (must be disabled before deletion is allowed). Default: `False`.
  - **`version`** *(string)*: Must be one of: `['4.2', '4.4', '5.0', '6.0']`. Default: `5.0`.
- **`mongodbatlas_creds`** *(object)*
  - **`organization_id`** *(string)*
  - **`private_key`** *(string)*
  - **`public_key`** *(string)*
- **`storage`** *(object)*
  - **`ebs_volume_type`** *(string)*: Type of storage you want to attach to your cluster. Must be one of: `['STANDARD', 'PROVISIONED']`. Default: `STANDARD`.
  - **`size_gb`** *(integer)*: The initial disk size (in GB) of the cluster. Disk autoscaling is enabled, so this value may increase as needed. Minimum: `10`. Maximum: `4096`. Default: `10`.
## Examples

  ```json
  {
      "__name": "Development",
      "backup": {
          "enabled": false
      },
      "database": {
          "autoscaling": {
              "instance_size_max": "M40",
              "instance_size_min": "M10"
          },
          "cluster_type": "REPLICASET",
          "termination_protection_enabled": false
      },
      "storage": {
          "size_gb": 10
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "backup": {
          "continuous": true,
          "enabled": true
      },
      "database": {
          "autoscaling": {
              "instance_size_max": "M80",
              "instance_size_min": "M10"
          },
          "cluster_type": "REPLICASET",
          "termination_protection_enabled": true
      },
      "storage": {
          "size_gb": 50
      }
  }
  ```

  ```json
  {
      "__name": "Sharded",
      "backup": {
          "continuous": true,
          "enabled": true
      },
      "database": {
          "autoscaling": {
              "instance_size_max": "M80",
              "instance_size_min": "M30"
          },
          "cluster_type": "REPLICASET",
          "num_shards": 2,
          "termination_protection_enabled": true
      },
      "storage": {
          "size_gb": 50
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`aws_authentication`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`arn`** *(string)*: Amazon Resource Name.

      Examples:
      ```json
      "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
      ```

      ```json
      "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
      ```

    - **`external_id`** *(string)*: An external ID is a piece of data that can be passed to the AssumeRole API of the Security Token Service (STS). You can then use the external ID in the condition element in a role's trust policy, allowing the role to be assumed only when a certain value is present in the external ID.
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

- **`vpc`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`arn`** *(string)*: Amazon Resource Name.

        Examples:
        ```json
        "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
        ```

        ```json
        "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
        ```

      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`internal_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`private_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
      - **`public_subnets`** *(array)*
        - **Items** *(object)*: AWS VCP Subnet.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

          - **`aws_zone`** *(string)*: AWS Availability Zone.

            Examples:
          - **`cidr`** *(string)*

            Examples:
            ```json
            "10.100.0.0/16"
            ```

            ```json
            "192.24.12.0/22"
            ```


          Examples:
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`mongodb`** *(object)*: mongo cluster authentication and cloud-specific configuration. Cannot contain additional properties.
  - **`data`** *(object)*
    - **`authentication`**: Mongo connection string. Cannot contain additional properties.
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Mongo cluster infrastructure configuration.
      - **One of**
        - Kuberenetes infrastructure config*object*: . Cannot contain additional properties.
          - **`kubernetes_namespace`** *(string)*
          - **`kubernetes_service`** *(string)*
        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - MongoDB Atlas Cluster Infrastructure*object*: Minimal MongoDB Atlas cluster infrastructure config. Cannot contain additional properties.
          - **`cluster_id`** *(string)*
          - **`project_id`** *(string)*
  - **`specs`** *(object)*
    - **`aws`** *(object)*: .
      - **`region`** *(string)*: AWS Region to provision in.

        Examples:
        ```json
        "us-west-2"
        ```

    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
    - **`gcp`** *(object)*: .
      - **`project`** *(string)*
      - **`region`** *(string)*: The GCP region to provision resources in.

        Examples:
        ```json
        "us-east1"
        ```

        ```json
        "us-east4"
        ```

        ```json
        "us-west1"
        ```

        ```json
        "us-west2"
        ```

        ```json
        "us-west3"
        ```

        ```json
        "us-west4"
        ```

        ```json
        "us-central1"
        ```

    - **`mongo`** *(object)*: Informs downstream bundles of Mongo specific data. Cannot contain additional properties.
      - **`version`** *(string)*: Currently deployed Mongo version.
<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/mongodbatlas-cluster-aws/issues>) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]


<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg

[docs]: https://docs.massdriver.cloud?utm_source=mongodbatlas-cluster-aws&utm_medium=mongodbatlas-cluster-aws&utm_campaign=mongodbatlas-cluster-aws&utm_content=mongodbatlas-cluster-aws
[website]: https://www.massdriver.cloud?utm_source=mongodbatlas-cluster-aws&utm_medium=mongodbatlas-cluster-aws&utm_campaign=mongodbatlas-cluster-aws&utm_content=mongodbatlas-cluster-aws
[github]: https://github.com/massdriver-cloud
[linkedin]: https://www.linkedin.com/company/massdriver/

[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/mongodbatlas-cluster-aws.svg?style=for-the-badge>
[contributors_url]: https://github.com/massdriver-cloud/mongodbatlas-cluster-aws/graphs/contributors>
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/mongodbatlas-cluster-aws.svg?style=for-the-badge>
[forks_url]: https://github.com/massdriver-cloud/mongodbatlas-cluster-aws/network/members>
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/mongodbatlas-cluster-aws.svg?style=for-the-badge>
[stars_url]: https://github.com/massdriver-cloud/mongodbatlas-cluster-aws/stargazers>
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/mongodbatlas-cluster-aws.svg?style=for-the-badge>
[issues_url]: https://github.com/massdriver-cloud/mongodbatlas-cluster-aws/issues>
[release_url]: https://github.com/massdriver-cloud/mongodbatlas-cluster-aws/releases/latest>
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/mongodbatlas-cluster-aws.svg?style=for-the-badge>
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/mongodbatlas-cluster-aws.svg?style=for-the-badge>
[license_url]: https://github.com/massdriver-cloud/mongodbatlas-cluster-aws/blob/main/LICENSE>

[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
