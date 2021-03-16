library(twitteR)
cred <- OAuthFactory$new(consumerKey="2q2Kc0bmJbdfisfFuLtTrw", 
                         consumerSecret="mSAwiCMCqy503soUYIOWUKTM3jloMVFFIC035n8gk8", 
                         requestURL="https://api.twitter.com/oauth/request_token", 
                         accessURL="https://api.twitter.com/oauth/access_token", 
                         authURL="http://api.twitter.com/oauth/authorize")

cred$handshake()
registerTwitterOAuth(cred)

#vagasTweets <- userTimeline('vagas')
#fbarthTweets <- userTimeline('fbarth')

dados <- searchTwitter('economist brasil', n=250)
df <- twListToDF(dados)
save(df, file="../data/20140424_economist_brasil.rda")
