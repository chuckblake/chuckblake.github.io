// get the ninja-keys element
const ninja = document.querySelector('ninja-keys');

// add the home and posts menu items
ninja.data = [{
    id: "nav-about",
    title: "about",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-projects",
          title: "projects",
          description: "Things I&#39;m building",
          section: "Navigation",
          handler: () => {
            window.location.href = "/projects/";
          },
        },{id: "nav-concerts",
          title: "concerts",
          description: "Shows I&#39;ve been to",
          section: "Navigation",
          handler: () => {
            window.location.href = "/concerts/";
          },
        },{id: "projects-lea",
          title: 'LEA',
          description: "AI-powered document extraction for wealth management",
          section: "Projects",handler: () => {
              window.location.href = "/projects/1_lea/";
            },},{id: "projects-getmusic-fm",
          title: 'GetMusic.fm',
          description: "Helping artists promote music on Bandcamp",
          section: "Projects",handler: () => {
              window.location.href = "/projects/2_getmusic/";
            },},{id: "projects-sonicsift",
          title: 'SonicSift',
          description: "Music news aggregator",
          section: "Projects",handler: () => {
              window.location.href = "/projects/3_sonicsift/";
            },},{id: "projects-indiecrates",
          title: 'IndieCrates',
          description: "Sister site to GetMusic.fm",
          section: "Projects",handler: () => {
              window.location.href = "/projects/4_indiecrates/";
            },},{
        id: 'social-email',
        title: 'email',
        section: 'Socials',
        handler: () => {
          window.open("mailto:%63%68%75%63%6B.%62%6C%61%6B%65@%67%6D%61%69%6C.%63%6F%6D", "_blank");
        },
      },{
        id: 'social-twitter_username',
        title: 'Twitter_username',
        section: 'Socials',
        handler: () => {
          window.open("", "_blank");
        },
      },{
        id: 'social-linkedin',
        title: 'LinkedIn',
        section: 'Socials',
        handler: () => {
          window.open("https://www.linkedin.com/in/chuckblake", "_blank");
        },
      },{
        id: 'social-github',
        title: 'GitHub',
        section: 'Socials',
        handler: () => {
          window.open("https://github.com/chuckblake", "_blank");
        },
      },{
        id: 'social-rss',
        title: 'RSS Feed',
        section: 'Socials',
        handler: () => {
          window.open("/feed.xml", "_blank");
        },
      },{
      id: 'light-theme',
      title: 'Change theme to light',
      description: 'Change the theme of the site to Light',
      section: 'Theme',
      handler: () => {
        setThemeSetting("light");
      },
    },
    {
      id: 'dark-theme',
      title: 'Change theme to dark',
      description: 'Change the theme of the site to Dark',
      section: 'Theme',
      handler: () => {
        setThemeSetting("dark");
      },
    },
    {
      id: 'system-theme',
      title: 'Use system default theme',
      description: 'Change the theme of the site to System Default',
      section: 'Theme',
      handler: () => {
        setThemeSetting("system");
      },
    },];
