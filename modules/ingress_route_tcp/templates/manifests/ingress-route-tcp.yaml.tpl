apiVersion: traefik.containo.us/v1alpha1
kind: IngressRouteTCP
metadata:
  ${indent(2, yamldecode(metadata))}
spec:
  entryPoints:
    ${indent(4, yamldecode(spec.entry_points))}
  routes:
  - match: HostSNI(`*`)
    services:
    - name: ${spec.routes.service.name}
      port: ${spec.routes.service.port}
%{ if try(spec.routes.service.proxy_protocol.enabled, false) ~}
      proxyProtocol:
        version: ${spec.routes.service.proxy_protocol.version}
%{ endif ~}
%{ if try(spec.tls.enabled, false) ~}
  tls:
    secretName: ${spec.tls.secret_name}
%{ endif ~}
