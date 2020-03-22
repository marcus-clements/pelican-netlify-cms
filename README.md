# Pelican with Netlify CMS

This repo provides the basics for a static site generated by [Pelican](https://blog.getpelican.com/), and managed by [Netlify CMS](https://www.netlifycms.org/). Deployments and hosting can also be managed by [Netlify](https://app.netlify.com/). 

Netlify CMS uses `Git Gateway` to allow users to edit content without having an account with write access to the repository. Git gateway is only currently supported for [Gitlab](https://gitlab.com/) and [Github](https://github.com/) hosted repositories.

Netfly CMS provides content editing of pages and articles. Netlify CMS commits changes directly to the repo on Publish.  Content is stored in the code repo in the `/content` directory and the static pages are generated in `/output`.

Note: content can also be edited by committing changes directly to the repository, however Netlify CMS expects a specific set of fields at the top of content items so it’s easy to make mistakes which stop the CMS from working properly.

If configured to host, Netlify triggers a deployment automatically when the repo changes. This takes anything from a few seconds to a couple of minutes.

## Developer Getting Started
It's a good idea to skim read the [Pelican Docs](https://docs.getpelican.com/en/stable/install.html)

Fork this repo in Gitlab or Github, clone it locally and `cd` into it. 

Setup a python virtual environment with [pyenv and virtualenv](https://github.com/pyenv/pyenv-virtualenv).
```
pyenv virtualenv pelican
pyenv local pelican
```

Install pelican and dependencies
```
pip install -r requirements.txt
```

Run pelican to read from the `content` directory and generate the site in the `output` directory - runs `pelican content`
```
make html
```

Run the pelican server to view the site at http://localhost:8000/ - runs `pelican --listen`
```
make serve
```

### Working on the theme

To be used by pelican the theme has to be installed see [Pelican Themes docs](http://docs.getpelican.com/en/stable/pelican-themes.html)
```
pelican-themes -i themes/bootstrap-next
```
Then it can be added in `pelicanconf.yml`
Then the content can be generated 
```
make html
```
So far I have had to remove then reinstall the theme and regenerate content to review changes but there may be a better way of editing the theme. Try:
```
make devserver
```

The site should now be visible at http://localhost:8000/

## Stay in sync!
The content can be edited in the CMS, so `git pull` frequently to stay in sync.

## File Structure and configuration

`pelicanconf.yml` is the main config file which can be overridden locally by `pelicanconf-local.yml`. See `pelicanconf-local.yml.example`

Netlify CMS files are in content/admin. The CMS is a single page React app included from a CDN in `/content/admin/index.html`. Netlify CMS is a generic CMS and is coupled to the structure and workflow of Pelican via config in `/content/admin/config.yml` 

```
├── Makefile
├── README.md
├── content                         # THE CONTENT EDITED IN THE CMS
│   ├── admin                           # NETLIFY CMS 
│   │   ├── config.yml                      # CONFIG FILE FOR NETLIFY CMS
│   │   └── index.html
│   ├── articles                    # ARTICLES FROM ANY CATEGORY
│   │   ├── ...
│   ├── extra                       # OTHER STATIC RESOURCES e.g favicon
│   │   └── ...
│   ├── images                      # UPLOADED IMAGES
│   │   ├── ...
│   └── pages                       # BASIC PAGES (NO CATEGORY)
│       └── ...
├── netlify-deploy.sh               # DEPLOY SCRIPT CONFIGURED TO RUN ON DEPLOY IN NETLIFY 
├── output                          # PUBLISHED WEB SITE
│   ├── ...
├── pelicanconf.py                  # MAIN PELICAN CONFIG
├── pelicanconf_local.example.py    
├── pelicanconf_local.py            # CREATE THIS FILE TO OVERRIDE CONFIG LOCALLY
├── plugins                         # PELICAN PLUGINS
│   └── i18n_subsites
│       ├── ...
├── publishconf.py
├── requirements.txt
├── tasks.py
└── themes                          # PELICAN THEMES
    ├── bootstrap-next                  # THEME BASE
    │   ├── ...

```

## Setup Netlify to deploy and host

Create an account on Netlify by logging in with whichever Git repo provider - Gitlab or Github - from here on assuming Gitlab

* Create "New site from Git"
* Choose Gitlab
* Authorise Netlify
* Choose your repo
* Build command should be `./neylify-deploy.sh`
* Output directory should be `output/`
* Deploy site

Netlify will now clone your repo, run `pelican content` to generate the site HTML in the output directory, and then host the output directory on the web.


## TODO
Themes are from [Pelican Themes](https://github.com/getpelican/pelican-themes)

Plugins are from [Pelican Plugins](https://github.com/getpelican/pelican-plugins)

These are copied and committed into the repo for now which is NAUGHTY. We should remove the plugins and themes and workout how to install them from git in the deploy script so that we don't have a copy of them in this repo.




