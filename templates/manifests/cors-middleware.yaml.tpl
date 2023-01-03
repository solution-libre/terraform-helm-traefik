apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: ${name}-cors
  namespace: ${namespace}
spec:
  headers:
%{ if access_control.allow.credentials }
    accessControlAllowCredentials: true
%{ endif }
%{ if access_control.allow.methods != null }
    accessControlAllowMethods:
      ${indent(6, yamlencode(access_control.allow.methods))}
%{ endif }
%{ if access_control.allow.origin_list != null }
    accessControlAllowOriginList:
      ${indent(6, yamlencode(access_control.allow.origin_list))}
%{ endif }
%{ if access_control.max_age != null }
    accessControlMaxAge: ${access_control.max_age}
%{ endif }
    addVaryHeader: true
