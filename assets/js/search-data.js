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
  },{id: "nav-fractional-cto",
          title: "fractional cto",
          description: "Technical leadership for early-stage startups",
          section: "Navigation",
          handler: () => {
            window.location.href = "/fractional-cto/";
          },
        },{id: "nav-projects",
          title: "projects",
          description: "Things I&#39;m building",
          section: "Navigation",
          handler: () => {
            window.location.href = "/projects/";
          },
        },{id: "nav-writing-amp-talks",
          title: "writing &amp; talks",
          description: "Writing, talks, and coverage.",
          section: "Navigation",
          handler: () => {
            window.location.href = "/publications/";
          },
        },{id: "nav-blog",
          title: "blog",
          description: "",
          section: "Navigation",
          handler: () => {
            window.location.href = "/blog/";
          },
        },{id: "nav-music",
          title: "music",
          description: "Shows I&#39;ve been to",
          section: "Navigation",
          handler: () => {
            window.location.href = "/music/";
          },
        },{id: "post-trust-is-not-a-vibe",
        
          title: "Trust Is Not a Vibe",
        
        description: "If I want agents to do real work, I need expectations, receipts, and escalation. Otherwise I&#39;m not delegating — I&#39;m hoping.",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/trust-is-not-a-vibe/";
          
        },
      },{id: "post-managing-agents-is-management-again",
        
          title: "Managing Agents is Management Again",
        
        description: "AI agents don&#39;t remove management. They remove the places where weak management used to hide.",
        section: "Posts",
        handler: () => {
          
            window.location.href = "/blog/2026/managing-agents-is-management-again/";
          
        },
      },{id: "projects-arwen",
          title: 'Arwen',
          description: "AI product work for high-volume social comment intelligence",
          section: "Projects",handler: () => {
              window.location.href = "/projects/0_arwen/";
            },},{id: "projects-lea",
          title: 'LEA',
          description: "AI document intelligence for enterprise wealth management — CTO &amp; co-founder",
          section: "Projects",handler: () => {
              window.location.href = "/projects/1_lea/";
            },},{id: "projects-getmusic-fm",
          title: 'GetMusic.fm',
          description: "Helping artists promote music on Bandcamp — AI-operated growth loops",
          section: "Projects",handler: () => {
              window.location.href = "/projects/2_getmusic/";
            },},{id: "projects-sonicsift",
          title: 'SonicSift',
          description: "Music news aggregator",
          section: "Projects",handler: () => {
              window.location.href = "/projects/3_sonicsift/";
            },},{id: "projects-indiecrates",
          title: 'IndieCrates',
          description: "Create and share Bandcamp playlists",
          section: "Projects",handler: () => {
              window.location.href = "/projects/4_indiecrates/";
            },},{id: "projects-glance",
          title: 'Glance',
          description: "Expectation monitoring for automated work — built in Rails, running in production",
          section: "Projects",handler: () => {
              window.location.href = "/projects/5_glance/";
            },},{id: "projects-email-insights",
          title: 'Email Insights',
          description: "Email marketing analytics SaaS — one of my first Rails products (sunset 2016)",
          section: "Projects",handler: () => {
              window.location.href = "/projects/6_emailinsights/";
            },},{id: "projects-recall-bridge",
          title: 'Recall Bridge',
          description: "A hosted AI memory layer — one persistent brain for every AI tool you use",
          section: "Projects",handler: () => {
              window.location.href = "/projects/7_recallbridge/";
            },},{id: "projects-corvoco",
          title: 'Corvoco',
          description: "Chill post-punk electronic music",
          section: "Projects",handler: () => {
              window.location.href = "/projects/8_corvoco/";
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
