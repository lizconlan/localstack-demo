# LocalStack running inside GitHub Actions

Having come from a place of using containers with the desired language version preinstalled to run my tests - this example happens to use Ruby but that's just because I like writing things in Ruby, you should use whatever works best for the code _you_ need to write - in Docker Compose (and then GitHub Actions), I was initially a bit confused to find that the GitHub Packages weren't working the way I'd hoped.

I span up a GitHub Actions version of the standard config that was already in place when I joined the project, tried to add LocalStack and … was met with either "unable to locate executable" or - even more depressing - a screenful of GLIBC version errors.

Fortunately the solution's a simple one. If you don't have control over the image - to allow you to upgrade to a newer OS version or to bake in the version of GNU libc that's demanded by the installer - simply, remove the `container:` (and `image`, if using) line(s) from your workflow file and install what you need directly into the OS specified by `runs-on:` instead, per https://docs.github.com/en/actions/writing-workflows/choosing-where-your-workflow-runs/running-jobs-in-a-container#example-running-a-job-within-a-container

Problem solved!

(Yes, you probably could figure out a way to install packages within your workflow but this will add more time - and therefore more cost - to your job steps (for each run!) compared with using a GitHub Package - so that's not an ideal solution.)

You can jump straight into [the example workflow file here](.github/workflows/localstack.workflow.yaml) if you don't want to wade through my example code.

Don't copy my test code though - it doesn't use AWS mocks for files properly because I'm mostly using this to prove that LocalStack is working inside GitHub Actions - from the Ruby code, rather than calling `awslocal` directly - using real files. The demo class is called `BadExample` for a reason!

---

If you found this useful - and can easily afford to - please consider [buying me a coffee!](https://buymeacoffee.com/lizconlan)
