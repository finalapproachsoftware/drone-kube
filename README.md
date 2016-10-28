# Drone on Google Container Engine

This directory contains various example deployments of Drone on [Google Container Engine](https://cloud.google.com/container-engine/).

**Note: While Drone supports a variety of different remotes, this demo assumes
that the projects you'll be building are on GitHub.**

## Prep work

**Before continuing on to one of the example setups below, you'll need to create a GKE cluster**, plus a persistent disk for the DB. Here's a rough run-down of that process:

### Create a Container Engine Cluster

There are a few different ways to create your cluster:

* If you don't have a strong preference, make sure your `gcloud` client is pointed at the GCP project you'd like the cluster created within. Next, run the `create-gke-cluster.sh` script in this directory. You'll end up with a cluster and a persistent disk for your DB. Your `gcloud` client will point `kubectl` at your new cluster for you.
* The Google Cloud Platform web console makes cluster creation very easy as well. See the [GKE docs](https://cloud.google.com/container-engine/docs/before-you-begin)), on how to go about this. You'll want to use an g1-small machine type or larger. If you create the cluster through the web console, you'll need to manually point your `kubectl` client at the cluster (via `gcloud container clusters get-credentials`).

### Create Drone Namespace

### Create a persistent disk for your sqlite DB

By default, these manifests will store all Drone state on a Google Cloud persistent disk via sqlite. As a consequence, we need an empty persistent disk before running the installer.

You can either do this in the GCP web console or via the `gcloud` command. In the case of the latter, you can use our `create-disk.sh` script after you open it up and verify that the options make sense for you.

In either case, make sure the persistent disk is named `drone-server-sqlite-db`. Also make sure that it is in the same availability zone as the GKE cluster.

## Choose an example deploy

At this point you should have a cluster and a persistent disk (both in the same AZ). Time to get to the fun stuff! Here are your options:

* `gke-with-http` - This is the simplest, fastest way to start playing with Drone. It stands up a fully-functioning cluster served over un-encrypted HTTP. This is *not* what you want in a more permanent, production-grade setup. However, it is a quick and easy way to get playing with Drone with a bare minimum setup process.
* `gke-with-https` - Unlike `gke-with-http`, this example setup is ready for production. It uses nginx + Let's Encrypt to automatically generate and rotate SSL certs. There are a few more steps involved, but the included install script walks you through the whole process interactively. If you

## Stuck? Need help?

We've glossed over quite a few details, for the sake of brevity. If you have questions, post them to our [Help!](https://discuss.drone.io/c/help) category on the Drone Discussion site. If you'd like a more realtime option, visit our [Gitter room](https://gitter.im/drone/drone).


# Drone on Google Container Engine (minimal example)

This directory contains an example of a simple but production-ready Drone install on [Google Container Engine](https://cloud.google.com/container-engine/). We use nginx and
[Let's Encrypt](https://letsencrypt.org/) to automatically generate a matching SSL cert for you at runtime.

**Note: While Drone supports a variety of different remotes, this demo assumes that the projects you'll be building are on GitHub.**

## Prep work

**Warning: Before proceeding, you should have followed the directions in the "Prep Work" section in the README.md found in this directory's parent.

## Install Drone

Finally, run `install-drone.sh` and follow the prompts carefully. At the end of the installation script, you should be able to point your browser at `https://drone.your-fqdn.com` and see a Login page.

## Compromises Made

This install script installs Drone on the cluster that is currently active in your `kubectl` client, in whatever namespace your current active context specifies (the `default` namespace if you haven't done anything to specifically change it). This is fine if Drone is the only thing running on your cluster, and is often fine even if that is not the case.

If you'd like to further isolate Drone from anything else running on your cluster, see the Kubernetes docs for [Sharing a Cluster with Namespaces](http://kubernetes.io/docs/admin/namespaces/). Before installing Drone, you'd want to create a new namespace, configure your `kubectl` context, set the context as active, *then* run the install script.

## Troubleshooting

You can verify that everything is running correctly like this:

```
kubectl get pods
```

You should see several pods in a "Running" state. If there were issues, note the name of the pod and look at the logs. This is a close approximation of what you'd need to type to check the nginx proxy logs:

```
kubectl logs -f drone-server-a123 nginx-proxy
```

Here's a close approximation of what you'd need to check the Drone server logs:

```
kubectl logs -f drone-server-a234 drone-server
```

And agent:

```
kubectl logs -f drone-agent-a345
```

Where ``drone-server-a123`` is the pod name.


## Stuck? Need help?

We've glossed over quite a few details, for the sake of brevity. If you have questions, post them to our [Help!](https://discuss.drone.io/c/help) category on the Drone Discussion site. If you'd like a more realtime option, visit our [Gitter room](https://gitter.im/drone/drone).
