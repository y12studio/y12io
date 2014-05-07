module.exports = function (grunt) {

	var etcdjs = require('etcdjs');
	var store = etcdjs('127.0.0.1:4001');
	var randomstring = require("randomstring");

	// Project configuration.
	grunt.initConfig({
		pkg : grunt.file.readJSON('package.json'),
		// Before generating any new files, remove any previously-created files.
		clean : {
			main : ['Dockerfile']
		},

		curl : {
			etcd_stats : {
				src : 'http://127.0.0.1:4001/v2/stats/self',
				dest : 'hello.json'
			}
		},

		http : {
			etcd_stats : {
				options : {
					url : 'http://127.0.0.1:4001/v2/stats/self',
					callback : function (err, response, body) {
						//grunt.log.write(body);
						console.log(body);
					}
				}
			}
		},

		exec : {
			grunt_help : 'grunt --help',
			echo_test : {
				cmd : function (name) {
					return 'echo ' + name + ' ...';
				}
			},
			// dk = docker / ubuntu 14.04 version
			// http://jimhoskins.com/2013/07/27/remove-untagged-docker-images.html
			dk_rm : {
				cmd : 'sudo docker.io rm $(sudo docker.io ps -a -q)',
				exitCodes : [0, 1, 2]
			},
			dk_rmi : {
				cmd : 'sudo docker.io rmi $(sudo docker.io images | grep "^<none>" | awk "{print $3}")',
				exitCodes : [0, 1, 2]
			},
			dk_ps : {
				cmd : 'sudo docker.io ps',
				exitCodes : [0, 1, 2]
			},
			dk_ip : {
				cmd : 'sudo docker.io ps -q | xargs -n 1 sudo docker.io inspect --format "{{ .Name }} {{ .NetworkSettings.IPAddress }}"',
				exitCodes : [0, 1, 2, 123]
			},
			dk_stop_all : {
				cmd : 'sudo docker.io stop $(sudo docker.io ps -q)',
				exitCodes : [0, 1, 2]
			},
			dk_build : {
				cmd : function (img) {
					return 'sudo docker.io build -t="' + img + '" .';
				},
				exitCodes : [0]
			},
			dk_run_ssl : {
				cmd : function (img) {
					return 'sudo docker.io run -d -p 443:443 -p 80:80 -p 8022:22 ' + img;
				},
				exitCodes : [0]
			},
			dk_run_etcd : {
				cmd : function () {
					return 'sudo docker.io run -d -p 4001:4001 -p 7001:7001 coreos/etcd';
				},
				exitCodes : [0]
			}
		},

		concat : {
			basic : {
				src : [
					'dockerfiles/Dockerfile.header',
				],
				dest : 'Dockerfile',
			}
		},

	});

	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-exec');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-zip');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-curl');
	grunt.loadNpmTasks('grunt-http');

	grunt.registerTask('xdk-build-basic', 'build docker basic image', function (img) {
		grunt.task.run('default', 'exec:dk_build:' + img);
	});

	grunt.registerTask('etcd-test-set', 'etcd test set', function () {
		var done = this.async();
		var ran = randomstring.generate(8);

		store.set('hello', 'Y12'+ran, function (err, result) {
			store.get('hello', function (err, result) {
				console.log('hello:', result.node.value);
				done(true);
			});
		});
	});

	grunt.registerTask('xdk-build-ssl', 'build docker ssl image', function (img) {
		grunt.task.run('df-ssl', 'exec:dk_build:' + img);
	});

	grunt.registerTask('xdk-brun-basic', 'stop, build and run basic docker image', function (img) {
		grunt.task.run('dk-stop-all', 'dk-build-basic:' + img, 'dk-run-basic:' + img);
	});

	grunt.registerTask('etcd-stats', 'etcd /stats/self', function () {
		grunt.task.run('http:etcd_stats');
	});

	grunt.registerTask('dk-run-etcd', 'run etcd docker image', function () {
		grunt.task.run('exec:dk_run_etcd', 'dk-psip', 'etcd-stats', 'etcd-test-set');
	});

	grunt.registerTask('dk-stop-all', 'Stop all docker container', ['exec:dk_stop_all']);
	grunt.registerTask('dk-psip', 'docker ps and ip', ['exec:dk_ps', 'exec:dk_ip']);
	grunt.registerTask('dk-clean', ['exec:dk_rm', 'exec:dk_rmi']);
	grunt.registerTask('df-basic', 'build basic Dockerfile', ['clean', 'concat:basic']);
	// Default task(s).
	grunt.registerTask('default', ['exec:grunt_help']);

};
