apiVersion: v1
kind: ConfigMap
metadata:
  creationTimestamp: 2016-03-30T21:14:38Z
  name: drone-config
  namespace: drone
data:

  ################
  # Proxy Config #
  ################

  # CHANGEME: This should be changed to a valid email for Let's Encrypt's
  # records.
  proxy.letsencrypt.email: your@email.com
  # CHANGEME: The Fully-Qualified Domain Name (FQDN) for where Drone will run.
  # No need to create a DNS entry just yet. The installer will walk you through
  # this process.
  proxy.fqdn: drone.yourdomain.com

  ################################
  # Drone Server (master) Config #
  ################################

  server.debug.is.enabled: "true"

  # You'll probably want to leave this alone, but you can point to external
  # DB instances if you'd like: http://readme.drone.io/0.5/manage/database/
  server.database.driver: sqlite3
  server.database.config: /var/lib/drone/drone.sqlite

  server.is.open: "true"
  # CHANGEME: If you want to restrict access to a particular org, put the
  # name here.
  server.orgs.list: ""
  # CHANGEME: Add your GitHub/Bitbucket/Gogs/etc username here. This is a
  # comma-separated list of usernames who will have admin privs.
  server.admin.list: admin,users,here
  server.admin.everyone.is.admin: "false"

  # See http://readme.drone.io/0.5/manage/server/ for possible values here.
  # For now, our demo is GitHub-only. Drone supports other remotes, we just
  # haven't set the others up in here yet.
  # CHANGEME: Substitute your Github OAuth application client ID and secret.
  server.remote.github.is.enabled: "true"
  server.remote.github.client.id: xxxxxxxxxxxxxxxxxxxx

  ######################
  # Drone Agent Config #
  ######################

  agent.debug.is.enabled: "true"
  # CHANGEME: Change this to point to the same FQDN as proxy.fqdn above.
  agent.drone.server.url: https://drone.yourdomain.com
