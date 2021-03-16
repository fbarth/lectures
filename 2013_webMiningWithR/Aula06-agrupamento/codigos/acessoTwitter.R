library(twitteR)
cred <- OAuthFactory$new(
             consumerKey="XXXX", 
             consumerSecret="XXXX", 
             requestURL="https://api.twitter.com/oauth/request_token", 
             accessURL="https://api.twitter.com/oauth/access_token", 
             authURL="http://api.twitter.com/oauth/authorize")

cred$handshake()
registerTwitterOAuth(cred)

about_protesto <- searchTwitter('#protestosp', n=250)
about_protesto_2 <- searchTwitter('sp', n=90)
prefeituraTweets <- userTimeline('Prefeitura_SP')

text <- c(about_protesto, about_protesto_2, prefeituraTweets)

df <- twListToDF(text)
save(df, file="../data/protesto.rda")
