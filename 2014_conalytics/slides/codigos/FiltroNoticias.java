public void classifyMessage(Instance instance) throws Exception {
// Convert message string into instance.
Instance instance = makeInstance(cleanupString(message));
// Filter instance.
m_Filter.input(instance);
Instance filteredInstance = m_Filter.output();
// Get index of predicted class value.
double predicted = m_Classifier.classifyInstance(filteredInstance);
// Classify instance.
System.err.println(\u201cMessage classified as : \u201c +
m_Data.classAttribute().value((int)predicted));
}
