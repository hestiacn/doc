<template>
	<header class="PageHeader">
		<div class="container">
			<h1>
				<slot name="title"></slot>
			</h1>
			<div v-if="$slots.aside" class="aside-container">
				<slot name="aside"></slot>
			</div>
		</div>
	</header>
</template>

<style scoped>
:root {
    --text-color-light: #282828;
    --text-color-dark: #f0f0f0;
}
.container {
	display: flex;
	margin: 0 auto;
	justify-content: center;
	max-width: 1260px;
	color: var(--text-color-light);
}

.aside-container {
	display: flex;
	flex-direction: column;  
	margin-left: auto;  
	margin-bottom: 15px; 
}

.PageHeader {  
    padding: 0 24px; 
    background-color: var(--vp-c-bg-alt);
    h1 {  
        margin: 0.75em 0; 
        font-size: 2rem;
        font-weight: 700; 
        line-height: inherit;
           
        @media (max-width: 640px) { 
            font-size: 20px;   
        }  
    }  
    
    @media (min-width: 640px) {  
        padding: 0 48px;  
    }    
  
    @media (min-width: 960px) {  
        padding: 0 64px;  
    }  
}  

</style>
