apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
%{ if length(metadata.annotations) > 0 ~}
  annotations:
    ${indent(4, yamlencode(metadata.annotations))}
%{ endif ~}
  name: ${metadata.name}
  namespace: ${metadata.namespace}
spec:
  entryPoints:
    ${indent(4, yamlencode(spec.entry_points))}
  routes:
    - kind: Rule
      match: Host(${join(",", formatlist("`%s`", spec.routes.match.hosts))})
%{~ if length(spec.routes.match.paths) > 0 || length(spec.routes.match.path_prefixes) > 0 ~}
 &&
%{~ if length(spec.routes.match.paths) > 0 && length(spec.routes.match.path_prefixes) > 0 ~}
 (
%{~ endif}
%{~ if length(spec.routes.match.paths) > 0 ~}
 Path(${join(",", formatlist("`%s`", spec.routes.match.paths))})
%{~ endif ~}
%{~ if length(spec.routes.match.paths) > 0 && length(spec.routes.match.path_prefixes) > 0 ~}
 ||
%{~ endif ~}
%{~ if length(spec.routes.match.path_prefixes) > 0 ~}
 PathPrefix(${join(",", formatlist("`%s`", spec.routes.match.path_prefixes))})
%{~ endif ~}
%{~ if length(spec.routes.match.paths) > 0 && length(spec.routes.match.path_prefixes) > 0 ~}
 )
%{~ endif }
%{~ endif }
%{ if length(spec.routes.middlewares) > 0 ~}
      middlewares:
%{ for middleware in spec.routes.middlewares ~}
        - name: ${middleware}
%{ endfor ~}
%{ endif ~}
%{ if spec.routes.priority != null ~}
      priority: ${spec.routes.priority}
%{ endif ~}
      services:
        - name: ${spec.routes.service.name}
          port: ${spec.routes.service.port}
%{ if spec.routes.service.sticky ~}
          sticky:
            cookie:
              name: lb_${spec.routes.service.name}
%{ endif ~}
  tls:
    secretName: ${spec.tls.secret_name}
