apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`${hostname}`)%{ if anytrue(values(redirect)) } || Host(`www.${hostname}`)%{ endif }
      kind: Rule
%{ if anytrue(values(redirect)) || access_control_enabled || length(middlewares) > 0 ~}
      middlewares:
%{ endif ~}
%{ if access_control_enabled }
        - name: ${name}-cors
%{ endif }
%{ if redirect.from_non_www_to_www ~}
        - name: from-non-www-to-www-redirect
%{ endif ~}
%{ if redirect.from_www_to_non_www ~}
        - name: from-www-to-non-www-redirect
%{ endif ~}
%{ for middleware in middlewares ~}
        - name: ${middleware}
%{ endfor ~}
      services:
        - name: ${service_name}
          port: ${service_port}
  tls:
    secretName: ${hostname}
