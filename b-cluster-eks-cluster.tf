#
# EKS Cluster Resources
#  * EKS Cluster
#
#  It can take a few minutes to provision on AWS

resource "aws_eks_cluster" "covid19" {
  name     = "${var.cluster-name}"
  role_arn = "${aws_iam_role.covid19-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.covid19-cluster.id}"]
    subnet_ids         = "${aws_subnet.covid19.*.id}"
  }

  depends_on = [
    "aws_iam_role_policy_attachment.covid19-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.covid19-cluster-AmazonEKSServicePolicy",
  ]
}
