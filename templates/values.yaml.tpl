additionalArguments:
  - --entrypoints.web.http.redirections.entrypoint.priority=10
%{ for value in ingress_routes_tcp ~}
  - --entrypoints.${value.entry_point.name}.address=:${value.entry_point.port}/tcp
%{ endfor ~}
deployment:
  enabled: ${deployment.enabled}
  kind: ${deployment.kind}
  replicas: ${deployment.replicas}
ingressRoute:
  dashboard:
    enabled: false
# logs:
#   general:
#     level: DEBUG
ports:
  web:
%{ if ports.http_to_https_redirection ~}
    redirectTo: websecure
%{ endif ~}
    proxyProtocol:
      trustedIPs: ${jsonencode(compact(["127.0.0.1/32", "10.0.0.0/8", "100.64.0.0/10", ports.lb_ip]))}
  websecure:
    middlewares:
      - ${namespace}-${name}-default@kubernetescrd
    proxyProtocol:
      trustedIPs: ${jsonencode(compact(["127.0.0.1/32", "10.0.0.0/8", "100.64.0.0/10", ports.lb_ip]))}
    tls:
      options: ${namespace}-${name}-default@kubernetescrd
%{ for value in ingress_routes_tcp ~}
  ${value.entry_point.name}:
    port: ${value.entry_point.port}
    expose: true
    exposedPort: ${value.entry_point.port}
    protocol: TCP
%{ endfor ~}
%{ if length(service.annotations) > 0 || service.ip_family_policy != null ~}
service:
%{ if length(service.annotations) > 0 ~}
  annotations:
%{ for key, value in service.annotations ~}
    ${key}: ${value}
%{ endfor ~}
%{ endif ~}
%{ if service.ip_family_policy != null ~}
  ipFamilyPolicy: ${service.ip_family_policy}
%{ endif ~}
%{ endif ~}
