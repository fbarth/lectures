library(twitteR)
cred <- OAuthFactory$new(consumerKey="2q2Kc0bmJbdfisfFuLtTrw", 
                         consumerSecret="mSAwiCMCqy503soUYIOWUKTM3jloMVFFIC035n8gk8", 
                         requestURL="https://api.twitter.com/oauth/request_token", 
                         accessURL="https://api.twitter.com/oauth/access_token", 
                         authURL="http://api.twitter.com/oauth/authorize")

cred$handshake()
registerTwitterOAuth(cred)

vagasTweets <- userTimeline('vagas')
fbarthTweets <- userTimeline('fbarth')

about_protesto <- searchTwitter('#protestosp', n=250)
about_protesto_2 <- searchTwitter('sp', n=90)
prefeituraTweets <- userTimeline('Prefeitura_SP')

text <- c(about_protesto, about_protesto_2, prefeituraTweets)

df <- twListToDF(text)
save(df, file="../data/protesto.rda")


