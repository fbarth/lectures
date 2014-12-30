public AgrupamentoComKMeans(String arquivo){
    try{
	Instances instances = new Instances(new FileReader(arquivo));
	/*
	 * Para visualizar os dados do arquivo arff
	 */
	System.out.println("Dataset: ");
	System.out.println(instances);
	
	/*
	 * Utilização do KMeans
	 */
	SimpleKMeans kmeans = new SimpleKMeans();
	kmeans.buildClusterer(instances);
	/*
	 * Imprimindo informação sobre instância - agrupamento
	 */
	for(int i=0; i<instances.numInstances(); i++){
	    System.out.println("A instância "+
			       instances.instance(i).toString()+
			       " estah no cluster "+
			       kmeans.clusterInstance(instances.instance(i)));
	}	
    }catch(Exception e){
	System.out.println(e);
    }
}
