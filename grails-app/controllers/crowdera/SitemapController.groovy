package crowdera

class SitemapController {
	def projectService

    def sitemap = {
            def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
	        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            render(contentType: 'text/xml', encoding: 'UTF-8') {
                mkp.yieldUnescaped '<?xml version="1.0" encoding="UTF-8"?>'
                urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9",
                        'xmlns:xsi': "http://www.w3.org/2001/XMLSchema-instance",
                        'xsi:schemaLocation': "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd") {
                    url {
                        loc(g.createLink(absolute: true, controller: 'home', action: 'index'))
                        changefreq('always')
                        priority(0.8)
                    }
					
					url {
						loc(base_url+'/howitworks/index')
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(base_url+'/termsofuse/index')
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(base_url+'/privacypolicy/index')
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(base_url+'/faq/index')
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(base_url+'/contactus/index')
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(base_url+'/404error')
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(base_url+'/401error')
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(base_url+'/ebook/index')
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(base_url+'/contactus/index')
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'project', action:'create'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'project', action:'validateList'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'project', action:'sendemail'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'user', action:'admindashboard'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'user', action:'dashboard'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: 'user', action: 'crewsList'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: 'community', action: 'manage'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: 'project', action: 'managecampaign'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'project', action:'sendemail'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'project', action:'sortCampaign'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: 'project', action: 'importprojects'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: 'user', action: 'crewsList'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: 'blog', action: 'manage'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'login', action:'facebook_user_denied'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'login', action:'facebook_user_login'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: 'fund', action: 'paypalReturn'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'user', action:'myproject'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'user', action:'mycontribution'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller: "error"))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'user', action:'accountSetting'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'user', action:'accountSetting'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'blog', action:'list'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'login', action:'list'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'blog', action:'show'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'project', action:'list'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'fund', action:'transaction'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'user', action:'list'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'user', action:'metric'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'project', action:'listwidget'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'project', action:'search'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'fund', action:'fund'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'project', action:'categoryFilter'))
						changefreq('always')
						priority(0.8)
					}
					
					url {
						loc(g.createLink(absolute: true, controller:'project', action:'validateList'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'fund', action:'checkout'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'login', action:'auth'))
						changefreq('always')
						priority(0.8)
					}

					url {
						loc(g.createLink(absolute: true, controller:'login', action:'register'))
						changefreq('always')
						priority(0.8)
					}
					

                    //dynamic entries
                    Project.list().each {project->
						def vanityTitle = projectService.getVanityTitleFromId(project.id)

						url {
							loc(g.createLink(absolute: true, controller: 'project', action: 'manageproject', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'preview', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'previewTile', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'edit', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'addFundRaiser', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'projectupdate', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'updatesaverender', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'showCampaign', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'show', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'thumbnail', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'validateshow', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'editUpdate', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'addcampaignsupporter', id:project.id))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'validateshow', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}

						url {
							loc(g.createLink(absolute: true, controller:'fund', action: 'fund', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller: 'fund', action: 'editContributionComment', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller: 'fund', action:'acknowledge', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'fund', action:'saveContributionComent', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'fund', action:'saveCommentRedirect', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'redirectCreateNow', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'launch', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'saveProject', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
						url {
							loc(g.createLink(absolute: true, controller:'project', action:'draftProject', params:[projectTitle:vanityTitle]))
							changefreq('always')
							priority(0.8)
						}
						
                    }
               }
          }
     }
}
