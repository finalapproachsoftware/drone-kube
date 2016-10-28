apiVersion: v1
kind: Secret
metadata:
  name: drone-secrets
  namespace: drone
type: Opaque
data:
  server.secret: REPLACE-THIS-WITH-BASE64-ENCODED-VALUE
  server.remote.github.secret: xxxxxxxxxxxxxxxxxxxxxxxxx