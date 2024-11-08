# Output the ARN of the ACM Certificate

output "certificate_arn" {
    value = aws_acm_certificate.cert.arn # ARN of the newly created ACM certificate
}