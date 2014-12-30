import edu.udo.cs.wvtool.generic.stemmer.PorterStemmerWrapper;
import edu.udo.cs.wvtool.generic.tokenizer.SimpleTokenizer;
import edu.udo.cs.wvtool.generic.wordfilter.StopWordsWrapper;

...

public String manipulaTextoComStemming(String nomeArquivo){
    try{
	WVTDocumentInfo documentInfo = new WVTDocumentInfo
	    (null,"html",null,"english");
	SimpleTokenizer tokenizer = new SimpleTokenizer();
	TokenEnumeration tokens = tokenizer.tokenize(
		new InputStreamReader(
			new FileInputStream(nomeArquivo)), documentInfo);
	PorterStemmerWrapper stemmer = new PorterStemmerWrapper();
	StopWordsWrapper stopWords = new StopWordsWrapper();
	TokenEnumeration tokenSemStopWord = stopWords.filter(
						tokens, documentInfo);
	String retorno = "";
	while(tokenSemStopWord.hasMoreTokens())
	    retorno = retorno + 
		stemmer.getBase(tokenSemStopWord.nextToken())+" "; 
	return retorno;
    ...
