Cancer Bioinformatics training session for graduate students.

Topics:

- quality control of somatic tumour mutations data;
- evolutionary inference from somatic tumour mutations data;


Known issue to install packages (**API RATE LIMIT error** or similar), please try the following steps

```
## set your user name and email:
usethis::use_git_config(user.name = "", user.email = "")

## create a personal access token for authentication:
usethis::create_github_token()
## in case usethis version < 2.0.0: usethis::browse_github_token() (or even better: update usethis!)

## set personal access token:
credentials::set_github_pat(" ")
```
