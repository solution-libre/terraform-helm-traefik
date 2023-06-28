apiVersion: traefik.containo.us/v1alpha1
kind: IngressRouteTCP
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  entryPoints:
    - ${entry_point}
  routes:
  - match: HostSNI(`*`)
    services:
    - name: ${service.name}
      port: ${service.port}
%{ if try(proxy_protocol.enabled, false) ~}
      proxyProtocol:
        version: ${proxy_protocol.version}
%{ endif ~}
%{ if try(tls.enabled, false) ~}
  tls:
    secretName: ${tls.secret_name}
%{ endif ~}
