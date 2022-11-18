additionalArguments:
  - --entrypoints.web.http.redirections.entrypoint.priority=10
ingressRoute:
  dashboard:
    enabled: false
# logs:
#   general:
#     level: DEBUG
ports:
  web:
    redirectTo: websecure
    proxyProtocol:
      trustedIPs: ["127.0.0.1/32","10.0.0.0/8"]
  websecure:
    proxyProtocol:
      trustedIPs: ["127.0.0.1/32","10.0.0.0/8"]
service:
%{if service_annotations != null}
  annotations: ${indent(4, service_annotations)}
%{endif}
  ipFamilyPolicy: PreferDualStack
