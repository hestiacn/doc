export const options = [
	{
        flag: 'port',
        label: '管理端口',
        description: '设置Hestia使用的HTTPS面板端口,默认为8083.此为必选项!',
        type: 'text',
        default: '8083',
    },
    {
        flag: 'lang',
        label: '面板WEB语言',
        description: '请选择适合您的WEB界面语言.若不进行选择.系统将默认使用英文.',
        type: 'select',
		default: 'en',
		options: [
			{ label: '阿尔巴尼亚语', value: 'sq' },
			{ label: '阿拉伯语语', value: 'ar' },
			{ label: '亚美尼亚语', value: 'hy' },
			{ label: '阿塞拜疆语', value: 'az' },
			{ label: '孟加拉语', value: 'bn' },
			{ label: '波斯尼亚语', value: 'bs' },
			{ label: '保加利亚语', value: 'bg' },
			{ label: '加泰罗尼亚语', value: 'ca' },
			{ label: '克罗地亚语', value: 'hr' },
			{ label: '捷克语', value: 'cs' },
			{ label: '丹麦语', value: 'da' },
			{ label: '荷兰语', value: 'nl' },
			{ label: '英语', value: 'en' },
			{ label: '芬兰语', value: 'fi' },
			{ label: '法语', value: 'fr' },
			{ label: '格鲁吉亚语', value: 'ka' },
			{ label: '德语', value: 'de' },
			{ label: '希腊语', value: 'el' },
			{ label: '匈牙利语', value: 'hu' },
			{ label: '印尼语', value: 'id' },
			{ label: '意大利语', value: 'it' },
			{ label: '日语', value: 'ja' },
			{ label: '韩语', value: 'ko' },
			{ label: '库尔德索拉尼语', value: 'ku' },
			{ label: '挪威语', value: 'no' },
			{ label: '波斯语', value: 'fa' },
			{ label: '波兰语', value: 'pl' },
			{ label: '葡萄牙语', value: 'pt' },
			{ label: '葡萄牙语(巴西)', value: 'pt-br' },
			{ label: '罗马尼亚语', value: 'ro' },
			{ label: '俄语', value: 'ru' },
			{ label: '塞尔维亚语', value: 'sr' },
			{ label: '简体中文(中国)', value: 'zh-cn' },
			{ label: '斯洛伐克语', value: 'sk' },
			{ label: '西班牙语', value: 'es' },
			{ label: '瑞典语', value: 'sv' },
			{ label: '泰语', value: 'th' },
			{ label: '繁体中文(台湾)', value: 'zh-tw' },
			{ label: '土耳其语', value: 'tr' },
			{ label: '乌克兰语', value: 'uk' },
			{ label: '乌尔都语', value: 'ur' },
			{ label: '越南语', value: 'vi' },
		],
	},
	{
		flag: 'hostname',
		label: '服务器主机名',
		description: '请设置WEB端服务器主机名.请遵循如下格式输入：demo.example.com 此为必须项!',
		type: 'text',
		default: '',
	},
	{
		flag: 'username',
		label: '服务器管理用户名',
		description: '请输入服务器管理帐户的用户名,此为必须项!',
		type: 'text',
		default: '',
	},
	{
		flag: 'email',
		label: '电子邮件',
		description: '请输入管理员帐户电子邮件,用于服务器配置异常通知提醒,此为必须项!',
		type: 'text',
		default: '',
	},
	{
		flag: 'password',
		label: '密码',
		description: '设置管理员帐户密码.不设置将随机生成.',
		type: 'text',
		default: '',
	},
	{
		flag: 'apache',
		label: 'Apache2',
		description: 'Apache2是一个功能强大.高度可配置.广泛支持的开源Web服务器.用于提供网站托管服务.支持Web应用程序.实现负载均衡和缓存等.',
		default: 'yes',
	},
	{
        flag: 'phpfpm',
        label: 'PHP-FPM',
        description: 'PHP-FPM 是一个 FastCGI 进程管理器,用于执行 PHP 脚本.',
        default: 'yes'
    },
    {
        flag: 'multiphp',
        label: 'MultiPHP',
        description: '允许选择安装多个 PHP 版本.默认安装 PHP 8.3,不勾选安装后可通过 CLI 命令或 web 管理面板安装需要的版本.',
        default: 'no'
    },
    {
        flag: 'vsftpd',
        label: 'VSFTPD',
        description: 'VSFTPD是一个安全、高速、稳定的FTP服务器软件.特别适用于Linux系统.用于在服务器与用户之间提供安全、快速的文件传输服务.',
        default: 'yes'
    },
    {
        flag: 'proftpd',
        label: 'ProFTPD',
        description: 'ProFTPD是一款高级模块化FTP服务器.支持通过LDAP进行用户身份验证和授权.',
        default: 'no'
    },
    {
        flag: 'named',
        label: 'BIND',
        description: 'BIND（Berkeley Internet Name Domain）是一个流行的 DNS 名称服务器软件,对于需要自定义 DNS 设置的服务器集群来说是必选项.',
        default: 'yes'
    },
    {
        flag: 'mysql',
        label: 'MariaDB',
        description: 'MariaDB 是 MySQL 的一个分支,提供了与 MySQL 兼容的特性和一些附加功能和改进.',
        default: 'yes'
    },
    {
        flag: 'mysql8',
        label: 'MySQL 8',
        description: 'MySQL 8 提供了易于设置.操作和缩放的功能.享受高级安全性.相同区域或区域冗余高可用性以及高达 99.99% 的服务级别协议 (SLA).',
        default: 'no'
    },
    {
        flag: 'postgresql',
        label: 'PostgreSQL',
        description: 'PostgreSQL 是一种强大的开源对象关系数据库系统,广泛应用于金融服务.制造业.零售业和物流等众多领域,可帮助开发者维护数据的完整性,更轻松地管理各种大小的工作负载.',
        default: 'no'
    },
	{
		flag: 'exim',
		label: 'Exim',
		description: 'Exim 是一个消息传输代理（MTA）,用于路由.传递和接收电子邮件消息.它允许从网络或本地程序通过 SMTP 发送电子邮件.',
		default: 'yes'
	},
	{
		flag: 'dovecot',
		label: 'Dovecot',
		description: 'Dovecot 是一个开源的 IMAP 和 POP3 电子邮件服务器软件,为 Linux 系统提供电子邮件服务.它以其安全性.易用性.速度和低资源消耗而著称.',
		default: 'yes'
	},
	{
		flag: 'sieve',
		label: 'Sieve 自定义规则',
		description: 'Sieve 是一种电子邮件过滤语言,允许管理员使用脚本来创建复杂的邮件过滤规则.这些规则可以用于检测敏感数据,并阻止其发送到网络外部,也可以用于行业或业务特定的内容过滤.',
		default: 'no'
	},
	{
		flag: 'clamav',
		label: 'ClamAV',
		description: 'ClamAV 是一个开源的跨平台电子邮件安全软件,用于检测电子邮件和其他文件中的病毒.',
		default: 'yes'
	},
	{
		flag: 'spamassassin',
		label: 'SpamAssassin',
		description: 'SpamAssassin 是一个用于识别和过滤垃圾邮件的开源工具.它通过检查邮件的标头.正文和发件人信息,应用一系列规则来评估邮件是否是垃圾邮件.',
		default: 'yes'
	},
	{
        flag: 'iptables',
        label: 'iptables',
        description: '使用iptables进行防火墙规则管理,增强系统安全性.',
        default: 'yes'
    },
    {
        flag: 'fail2ban',
        label: 'Fail2Ban',
        description: 'Fail2Ban可以自动检测和封禁尝试使用无效身份验证信息的用户,如SSH.FTP等.',
        default: 'yes'
    },
    {
        flag: 'quota',
        label: '硬盘配额',
        description: '为系统用户设置磁盘空间配额,限制硬盘使用空间.',
        default: 'no'
    },
    {
        flag: 'webterminal',
        label: ' SSH 网络终端',
        description: '通过Hestia控制面板提供基于Web的SSH终端访问.',
        default: 'no'
    },
    {
        flag: 'api',
        label: 'Hestia API',
        description: '启用Hestia的内部API,允许其他系统或服务与之交互.',
        default: 'yes'
    },
    {
        flag: 'interactive',
        label: '交互运行安装',
        description: '在安装过程中启用交互式模式,以便用户能够响应提示和选择.',
        default: 'yes'
    },
    {
        flag: 'force',
        label: '强制安装',
        description: '强制覆盖任何现有的配置和文件,进行安装.在Ubuntu系统上建议勾选需要此选项.覆盖默认admin的配置',
        default: 'no'
    },
];
