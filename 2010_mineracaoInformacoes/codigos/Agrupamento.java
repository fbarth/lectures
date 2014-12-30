public AgrupamentoComKMeans(String arquivo){
    try{
	Instances instances = new Instances(new FileReader(arquivo));
	/*
	 * Para visualizar os dados do arquivo arff
	 */
	System.out.println("Dataset: ");
	System.out.println(instances);
	
	/*
	 * Utiliza��o do KMeans
	 */
	SimpleKMeans kmeans = new SimpleKMeans();
	kmeans.buildClusterer(instances);
	/*
	 * Imprimindo informa��o sobre inst�ncia - agrupamento
	 */
	for(int i=0; i<instances.numInstances(); i++){
	    System.out.println("A inst�ncia "+
			       instances.instance(i).toString()+
			       " estah no cluster "+
			       kmeans.clusterInstance(instances.instance(i)));
	}	
    }catch(Exception e){
	System.out.println(e);
    }
}
