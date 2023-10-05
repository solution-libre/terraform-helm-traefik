apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  entryPoints:
    - websecure
  routes:
    - kind: Rule
      match: Host(${join(",", formatlist("`%s`", match.hosts))})
%{~ if length(match.paths) > 0 || length(match.path_prefixes) > 0 ~}
 &&
%{~ if length(match.paths) > 0 && length(match.path_prefixes) > 0 ~}
 (
%{~ endif}
%{~ if length(match.paths) > 0 ~}
 Path(${join(",", formatlist("`%s`", match.paths))})
%{~ endif ~}
%{~ if length(match.paths) > 0 && length(match.path_prefixes) > 0 ~}
 ||
%{~ endif ~}
%{~ if length(match.path_prefixes) > 0 ~}
 PathPrefix(${join(",", formatlist("`%s`", match.path_prefixes))})
%{~ endif ~}
%{~ if length(match.paths) > 0 && length(match.path_prefixes) > 0 ~}
 )
%{~ endif}
%{~ endif}
%{ if anytrue(values(redirect)) || length(middlewares) > 0 ~}
      middlewares:
%{ endif ~}
%{ if redirect.from_non_www_to_www ~}
        - name: from-non-www-to-www-redirect
%{ endif ~}
%{ if redirect.from_www_to_non_www ~}
        - name: from-www-to-non-www-redirect
%{ endif ~}
%{ for middleware in middlewares ~}
        - name: ${middleware}
%{ endfor ~}
%{ if priority != null ~}
      priority: ${priority}
%{ endif ~}
      services:
        - name: ${service.name}
          port: ${service.port}
%{ if service.sticky ~}
          sticky:
            cookie:
              name: lb_${service.name}
%{ endif ~}
  tls:
    secretName: ${tls.secret_name}
