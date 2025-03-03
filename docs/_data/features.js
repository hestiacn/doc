/** @typedef {{ text: string, items?: { text: string }[] }} FeatureListItem */

/** @type {FeatureListItem[]} */
export const users = [
	{ text: 'chroot jail 是一种安全机制,它通过限制SFTP用户的根目录来增强系统安全性,确保用户只能在指定目录内进行文件传输操作,防止访问系统敏感区域.' },
	{ text: 'Hestia管理面板支持双因素认证(2FA),即在密码验证后,还需提供第二种验证信息(如手机验证码)来增强账户安全.' },
	{ text: 'SSH keys 是用于 SFTP 和 SSH 登录的安全方式,包括公钥和私钥.用户生成密钥对后,将公钥存储在服务器上,私钥保存在本地.通过私钥验证,无需密码即可安全登录 SFTP 或 SSH 服务器.' },
];

/** @type {FeatureListItem[]} */
export const webDomains = [
	{ text: 'Nginx FastCGI 缓存支持 Nginx + PHP-FPM' },
	{ text: 'Nginx 代理缓存支持 Nginx + Apache2' },
	{ text: 'Web 域的每个域 TLS 证书' },
	{ text: '对 Web/ 邮件 /DNS 的 MultiIP 支持' },
	{ text: '支持 PHP 版本 5.6 至 8.4,默认为 PHP8.3' },
	{ text: "支持一键快速安装以下应用程序, 支持用户自定义配置, 请查看<a href='/docs/contributing/quick-install-app' rel='noopener noreferrer'>快速安装应用程序配置</a>",
    apps: [
		{
		  text: 'Dokuwiki',
		  iconType: 'image',
		  icon: 'Dokuwiki.svg'
		},
		{
		  text: 'Dolibarr',
		  iconType: 'image',
		  icon: 'dolibarr.svg'
		},
		{
		  text: 'Drupal',
		  iconType: 'fontawesome',
		  icon: 'fab fa-drupal'
		},
		{
		  text: 'Flarum',
		  iconType: 'image',
		  icon: 'Flarum.svg'
		},
		{
		  text: 'Grav',
		  iconType: 'image', 
		  icon: 'grav.svg'
		},
		{
		  text: 'Joomla',
		  iconType: 'fontawesome',
		  icon: 'fab fa-joomla'
		},
		{
		  text: 'Laravel',
		  iconType: 'fontawesome',
		  icon: 'fab fa-laravel'
		},
		{
		  text: 'MediaWiki',
		  iconType: 'image',
		  icon: 'mediawikiwiki.svg'
		},
		{
		  text: 'NamelessMC',
		  iconType: 'image',
		  icon: 'NamelessMC.svg'
		},
		{
		  text: 'NextCloud',
		  iconType: 'image',
		  icon: 'NextCloud.svg'
		},
		{
		  text: 'OpenCart',
		  iconType: 'image',
		  icon: 'OpenCart.svg'
		},
		{
		  text: 'Prestashop',
		  iconType: 'image',
		  icon: 'PrestaShop.svg'
		},
		{
		  text: 'Symfony',
		  iconType: 'image',
		  icon: 'Symfony.svg'
		},
		{
		  text: 'ThirtyBees',
		  iconType: 'image',
		  icon: 'ThirtyBees.svg'
		},
		{
		  text: 'Vvveb',
		  iconType: 'image',
		  icon: 'Vvveb.png'
		},
		{
		  text: 'WordPress',
		  iconType: 'fontawesome',
		  icon: 'fab fa-wordpress'
		}
	  ]
	},
];

/** @type {FeatureListItem[]} */
export const mail = [
	{ text: '支持入站和出站邮件服务的每个邮箱域 TLS 证书(Exim 4、Dovecot、Webmail配置)'},
	{ text: 'Exim的SMTP中继设置,以防端口 25 被提供商阻止' },
	{ text: '每个用户或电子邮件帐户可调整的速率限制' },
	{ text: 'Lets Encrypt 对邮件域的支持提供免费自动化的SSL/TLS证书促进HTTPS的广泛采用增强网站安全性' },
	{ text: 'Roundcube 基于Web的IMAP邮件客户端,使用Ajax技术,界面直观现代,开源且稳定,支持多平台,易于集成,提供安全便捷的邮件服务' },
	{ text: '可选的安装 SnappyMail 组件高效快捷,界面友好,支持多平台,邮件处理迅速,安全可靠,满足用户日常邮件沟通需求' },
];

/** @type {FeatureListItem[]} */
export const dns = [  
	{ text: '配置DNS集群，实现高可用、负载均衡和强大容错能力，提供稳定且快速的域名解析服务，确保网络访问的流畅性和高效性。' },  
	{ text: '支持DNSSEC标准，增强DNS安全性，有效防止数据篡改和伪造，保障域名解析的完整性和真实性，为互联网用户提供更加安全可靠的访问体验。' },  
	{ text: '实时监控与预警功能，及时发现并解决DNS问题，确保服务的连续性和可用性。' },  
	{ text: '灵活的扩展性，轻松应对不断增长的域名解析需求，无需担心性能瓶颈。' },  
];
/** @type {FeatureListItem[]} */
export const databases = [
	{ text: '支持 MariaDB 10.2 -> 10.11,默认为 10.11' },
	{ text: '支持 MySQL 8' },
	{ text: '支持 PostgreSQL' },
	{ text: '最新版本的 phpMyAdmin 和 phpPgAdmin' },
];

/** @type {FeatureListItem[]} */
export const serverAdmin = [
	{ text: '使用 Hestia 控制面板，可以轻松设置自动备份到 SFTP 或 FTP 服务器。管理员只需配置备份参数和频率，Hestia 将自动执行备份任务，确保数据安全地复制到远程服务器。' },
	{ text: '支持 SFTP 提供加密连接，保障数据传输安全。FTP 作为另一种选择，适用于不同安全需求的场景。' },
	{ text: "通过 <a href='https://rclone.org/overview' target='_blank' rel='noopener noreferrer'>Rclone</a> 支持与超过 50 家<a href='rclone' rel='noopener noreferrer'>云存储提供商</a>同步，包括 <a href='https://www.google.com/drive' target='_blank' rel='noopener noreferrer'>Google Drive</a>、<a href='https://aws.amazon.com/s3' target='_blank' rel='noopener noreferrer'>Amazon S3</a>、<a href='https://www.dropbox.com' target='_blank' rel='noopener noreferrer'>Dropbox</a> 等，提供灵活的数据备份和恢复选项。" },
	{ text: '自动备份功能确保数据定期备份，降低数据丢失风险，同时减少手动管理备份的负担。' },
	{ text: '提供多种备份目标和协议，使管理员能够根据需求选择最合适的备份策略，无论是本地还是云端备份。' },
	{ text: '除了自动备份，Hestia 还包括用户管理、服务监控、安全配置等功能，简化服务器管理，无论是个人项目还是大型企业应用，Hestia 都能提供卓越的服务器管理体验。' },
  ];