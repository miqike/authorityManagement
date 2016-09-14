// fis.match('::packager', {
//   spriter: fis.plugin('csssprites')
// });

// fis.match('*', {
//   useHash: false
// });

// fis.match('*.js', {
//   optimizer: fis.plugin('uglify-js')
// });

// fis.match('*.css', {
//   useSprite: true,
//   optimizer: fis.plugin('clean-css')
// });

// fis.match('*.png', {
//   optimizer: fis.plugin('png-compressor')
// });
fis.hook('relative');
fis.set('namespace', 'cpsi')

// 让所有文件，都使用相对路径。 
fis.match('**', {
	relative: true
})

fis.match('*.js', {
	// fis-optimizer-uglify-js 插件进行压缩，已内置
	optimizer: fis.plugin('uglify-js')
});

fis.match('*.css', {
	useSprite: true,
	// fis-optimizer-clean-css 插件进行压缩，已内置
	optimizer: fis.plugin('clean-css')
});

fis.match('*.png', {
  // fis-optimizer-png-compressor 插件进行压缩，已内置
  optimizer: fis.plugin('png-compressor')
});

//将选中的文件加入到静态映射表中
fis.match('*.{png,jpg}',{
    useMap: false
});

fis.match('*.{gif,jpg,png,js,css}', {
	relative: true,
	useHash: true
});

fis.match('/css/jquery-easyui-theme/*.{png,js,css}', {
	relative: true,
	useHash: false
});

fis.match('jquery.jdirk.min.js', {
	useHash: false
});
fis.match('jeasyui.extensions.all.min.js', {
	useHash: false
});
fis.match('jquery.ztree.core-3.5.min.js', {
	useHash: false
});
fis.match('jquery.ztree.excheck-3.5.min.js', {
	useHash: false
});
fis.match('jquery.ztree.exedit-3.5.min.js', {
	useHash: false
});
fis.match('jquery.ztree.exhide-3.5.min.js', {
	useHash: false
});
fis.match('pinyin.js', {
	useHash: false
});
fis.match('underscore-min-1.8.3.js', {
	useHash: false
});

fis.match('/js/plugins/**.{gif,png,js,css}', {
	useHash: false
});

fis.match('/js/jquery/**.{gif,png,js,css}', {
	useHash: false
});

fis.match('/js/jquery-easyui-1.3.6/**.{gif,png,js,css}', {
	useHash: false
});

fis.match('/js/jeasyui-extensions/**.{gif,png,js,css}', {
	useHash: false
});

fis.match('/js/jeasyui-extensions-release/**.{gif,png,js,css}', {
	useHash: false
});

fis.match('/js/fine-uploader/**.{gif,png,js,css}', {
	useHash: false
});

fis.match('/css/jquery-easyui-theme/**.{gif,png,js,css}', {
	useHash: false
});

fis.match('/css/themes/**.{gif,png,js,css}', {
	useHash: false
});