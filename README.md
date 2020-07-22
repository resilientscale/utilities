# utilities

Random utilities that may or may not be useful.


## Replace master with main in Github

This script will replace the `master` branch with a branch called `main` in github. The script assumes you also have a local clone of the repository already. To use:

- Set the `GITHUB_USERNAME` and `GITHUB_PASSWORD` environment variables using credentials that have the right to set the default branch via the github api.

```
./migrate-to-main-branch.bash <path to local clone>
```
