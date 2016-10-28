# Drone on Kubernetes Using GKE
Below are the steps to deploy a drone server on [Google Container Engine](https://cloud.google.com/container-engine/) using [Let's Encrypt](https://letsencrypt.org/) to automatically 
generate a matching SSL cert at runtime.

## Create a Container Engine Cluster

The Google Cloud Platform web console makes cluster creation very easy. See the [GKE docs](https://cloud.google.com/container-engine/docs/before-you-begin), on how to go about this. You'll want to use an g1-small machine type or larger. 
You'll need to manually point your `kubectl` client at the cluster (via `gcloud container clusters get-credentials`).

## Create a persistent disk for your sqlite DB

By default, these manifests will store all Drone state on a Google Cloud persistent disk via sqlite. As a consequence, we need an empty persistent disk before running the installer.

You can either do this in the GCP web console or via the `gcloud` command. In the case of the latter, you can use our `create-disk.sh` script after you open it up and verify that the options make sense for you.

In either case, make sure the persistent disk is named `drone-server-sqlite-db`. Also make sure that it is in the same availability zone as the GKE cluster.

**Note: While Drone supports a variety of different remotes, this demo assumes that the projects you'll be building are on GitHub.**

## Install Drone

Finally, run `install-drone.sh` and follow the prompts carefully. At the end of the installation script, you should be able to point your browser at `https://drone.your-fqdn.com` and
see a Login page.

## Troubleshooting

You can verify that everything is running correctly like this:

```
kubectl get pods
```

You should see several pods in a "Running" state. If there were issues, note the name of the pod and look at the logs. This is a close approximation of what you'd need to type to check the nginx proxy logs:


Here's a close approximation of what you'd need to check the Drone server logs:

```
kubectl logs -f drone-server-a234 drone-server
```

And agent:

```
kubectl logs -f drone-agent-a345
```

Where ``drone-server-a123`` is the pod name.
