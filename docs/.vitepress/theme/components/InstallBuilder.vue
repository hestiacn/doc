<template>
	<div class="InstallBuilder">
		<div class="container">
			<div class="output-card">
				<h1 class="u-text-center">安装说明</h1>
				<h2 class="u-text-center">中国大陆境内服务器安装请<a href='https://bbs.hestiamb.org/d/15-%E4%B8%AD%E5%9B%BD%E5%A4%A7%E9%99%86%E5%A2%83%E5%86%85%E4%B8%BB%E6%9C%BA%E5%AE%89%E8%A3%85hestiacp%E6%8C%87%E5%8D%97' target='_blank' rel='noopener noreferrer'>加速github</a>后进行以下操作！</h2>
				<p class="u-mb10">登录到您的服务器,例如: <code>ssh root@1.1.1.1</code> 然后复制以下github官方安装脚本:[英文原版安装请选择github官方脚本]</p>
				<CopyToClipboardInput
					class="u-mb10"
					value="wget https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh"/>
				<p class="u-mb10">登录到您的服务器,例如: <code>ssh root@1.1.1.1</code> 然后复制以下本站安装脚本:[汉化安装选择本站脚本 | 大陆境内速度服务器略慢]</p>
				<CopyToClipboardInput
					class="u-mb10"
					value="wget https://hestiamb.org/install/hst-install.sh"/>
				<p class="u-mb10">检查您是否以 <code>root</code> 管理员身份运行服务器,在下面选项框配置您需要的选项,复制后在服务器管理终端运行配置好的安装代码：</p>
				<CopyToClipboardInput class="u-mb10" :value="installCommand" />
			</div>
			<h2 class="u-text-center">配置选项:请根据实际需要进行配置</h2>
			<h3 class="u-text-center"><i class="fa-solid fa-triangle-exclamation"></i> 温馨提示:建议在此处进行完整的配置选择,否则在终端您将再次输入需要的信息！提示:(1.3.4.5.6.为必选项)</h3>
			<ul class="option-list">
				<li
					v-for="option in options"
					:key="option.flag"
					:class="{
						'option-item': true,
						'is-active': selectedOptions[option.flag].enabled,
						'is-clickable': !option.type || !selectedOptions[option.flag].enabled,
					}"
					@click="toggleOption(option)"
				>
					<div class="option-header">
						<div class="form-check">
							<input
								type="checkbox"
								class="form-check-input"
								:id="option.flag"
								v-model="selectedOptions[option.flag].enabled"
							/>
							<label :for="option.flag" @click.stop>{{ option.label }}</label>
						</div>
						<div class="option-icon" v-tooltip="option.description">
							<i class="fa-solid fa-circle-info"></i>
						</div>
					</div>
					<div v-if="selectedOptions[option.flag].enabled && option.type" class="option-content">
						<label
							v-if="option.type && option.type !== 'checkbox'"
							class="form-label"
							:for="`${option.flag}-input`"
						>
							{{ option.description }}
						</label>
						<input
							v-if="option.type === 'text'"
							class="form-control"
							type="text"
							:id="`${option.flag}-input`"
							v-model="selectedOptions[option.flag].value"
						/>
						<select
							v-if="option.type === 'select'"
							class="form-select"
							:id="`${option.flag}-input`"
							v-model="selectedOptions[option.flag].value"
						>
							<option v-for="opt in option.options" :key="opt.value" :value="opt.value">
								{{ opt.label }}
							</option>
						</select>
					</div>
				</li>
			</ul>
		</div>
	</div>
</template>

<script setup>
import { ref, watchEffect } from "vue";
import CopyToClipboardInput from "./CopyToClipboardInput.vue";

const { options } = defineProps({
	options: {
		type: Array,
		required: true,
	},
});

const selectedOptions = ref({});
options.forEach((option) => {
	selectedOptions.value[option.flag] = {
		enabled: option.default === "yes",
		value: option.default !== "yes" && option.default !== "no" ? option.default : null,
	};
});

const toggleOption = (option) => {
	if (!option.type || !selectedOptions.value[option.flag].enabled) {
		selectedOptions.value[option.flag].enabled = !selectedOptions.value[option.flag].enabled;
	}
};

const installCommand = ref("bash hst-install.sh");
watchEffect(() => {
	let cmd = "bash hst-install.sh";
	for (const [key, { enabled, value }] of Object.entries(selectedOptions.value)) {
		const opt = options.find((o) => o.flag === key);
		if (opt.flag == "force" && enabled) {
			cmd += ` --force`;
		} else if (!opt.type || opt.type === "checkbox") {
			if (enabled !== (opt.default === "yes")) {
				cmd += ` --${key} ${enabled ? "yes" : "no"}`;
			}
		} else if (enabled && value !== opt.default) {
			cmd += ` --${key} ${value}`;
		}
	}
	installCommand.value = cmd;
});
</script>

<style scoped>
.InstallBuilder {
	padding: 0 24px;

	@media (min-width: 640px) {
		padding: 0 48px;
	}

	@media (min-width: 960px) {
		padding: 0 72px;
	}
}
:root {
    --text-color-light: #282828;
    --text-color-dark: #f0f0f0;
}
h1 {
    font-size: 32px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 30px;
	color: var(--text-color-light);
}
h2 {
	font-size: 24px;
	font-weight: 600;
	margin-bottom: 25px;
	color: var(--text-color-light);
}

h3 {
	font-size: 20px;
	font-weight: 500;
	margin-bottom: 20px;
	color: #b7236a;
	font-weight: bold;
}
@media (max-width: 640px) {  
    h1 { font-size: 20px; }   
    h2 { font-size: 18px; }   
    h3 { font-size: 16px; } 
}  
p {
    font-size: 16px;
    font-weight: bold;
    line-height: 1.6;
    margin-bottom: 15px;
    color: var(--text-color-light);
}
a {
    color: var(--vp-button-brand-active-bg);
    text-decoration: none;
}
a:visited {
    color: var(--vp-button-brand-active-bg);
}
a:hover {
    color: var(--vp-button-brand-hover-bg);
}
a:active {
    color: var(--vp-button-brand-hover-bg);
}
.container {
	display: flex;
	flex-direction: column;
	margin: 0 auto;
	max-width: 1152px;
}
.output-card {
	background-color: var(--vp-c-bg-alt);
	border-radius: 10px;
	padding: 30px;
	margin-top: 40px;
	margin-bottom: 40px;

	@media (min-width: 640px) {
		padding: 30px 50px;
	}
}
.option-list {
	display: grid;
	grid-gap: 23px;
	margin-bottom: 50px;

	@media (min-width: 640px) {
		grid-template-columns: 1fr 1fr;
	}

	@media (min-width: 960px) {
		grid-template-columns: 1fr 1fr 1fr;
	}
}
.option-item {
	font-size: 0.9em;
	border-radius: 10px;
	border: 2px solid transparent;
	padding: 10px 20px;
	background-color: var(--vp-c-bg-alt);
	transition: border-color 0.2s;

	&:hover {
		border-color: var(--vp-button-brand-hover-bg);
	}

	&.is-active {
		border-color: var(--vp-button-brand-active-bg);
	}
}
.option-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
}
.option-icon {
	padding: 5px;
	margin-right: -5px;

	& i {
		opacity: 0.7;
	}

	&:hover i {
		opacity: 1;
	}
}
.option-content {
	margin-top: 5px;
	margin-bottom: 5px;
}
.form-label {
	display: inline-block;
	font-size: 16px;
	line-height: 1.5;
	padding-bottom: 5px;
}
.form-control {
	font-size: 0.9em;
	border: 1px solid var(--vp-c-border);
	border-radius: 4px;
	background-color: var(--vp-c-bg);
	width: 100%;
	padding: 5px 10px;

	&:hover {
		border-color: var(--vp-c-border-hover);
	}

	&:focus {
		border-color: var(--vp-c-brand);
	}
}
.form-select {
	appearance: auto;
	font-size: 0.9em;
	border: 1px solid var(--vp-c-border);
	border-radius: 4px;
	background-color: var(--vp-c-bg);
	padding: 6px;
	width: 100%;

	&:hover {
		border-color: var(--vp-c-border-hover);
	}

	&:focus {
		border-color: var(--vp-c-brand);
	}
}
.form-check {
	flex-grow: 1;
	position: relative;
	padding-left: 25px;

	& label {
		font-size: 16px;
		font-weight: 600;
		display: block;
		line-height: 1.6;

		&:hover {
			cursor: pointer;
		}
	}
}
.form-check-input {
	cursor: pointer;
	position: absolute;
	width: 15px;
	height: 15px;
	margin-top: 5px;
	margin-left: -25px;
}
.u-mb10 {
	margin-bottom: 10px !important;
}
.u-text-center {
	text-align: center !important;
}
.is-clickable {
	cursor: pointer;
}
</style>
