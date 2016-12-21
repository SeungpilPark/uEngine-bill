var workflowData = [
    {
        category : 'hadoop',
        text: message.msg('workflowdata.hadoop'),
        list : [
            {text: 'Map reduce' , img : '/resources/images/flamingo/workflow/workflow-hadoop.png'},
            {text: 'Apache Pig' , img : '/resources/images/flamingo/workflow/workflow-pig.png'},
            {text: 'Apache Hive' , img : '/resources/images/flamingo/workflow/workflow-hive.png'},
            {text: 'Java' , img : '/resources/images/flamingo/workflow/workflow-java.png'}
        ]
    },
    {
        category : 'dataprocessing',
        text: message.msg('workflowdata.dataprocessing'),
        list : [
            {text: 'Min/Max Normalization' , img : '/resources/images/flamingo/workflow/workflow-etl.png'},
            {text: 'Remove Characters' , img : '/resources/images/flamingo/workflow/workflow-etl.png'},
            {text: 'Apache Access To CSV' , img : '/resources/images/flamingo/workflow/workflow-etl.png'},
            {text: 'UIMA To Sequence File' , img : '/resources/images/flamingo/workflow/workflow-etl.png'},
            {text: 'UIMA Application' , img : '/resources/images/flamingo/workflow/workflow-etl.png'}
        ]
    },
    {
        category : 'statistics',
        text: message.msg('workflowdata.statistics'),
        list : [
            {text: 'Numeric Statistics Distribution' , img : '/resources/images/flamingo/workflow/workflow-statistics.png'},
            {text: 'Nominal Statistics Distribution' , img : '/resources/images/flamingo/workflow/workflow-statistics.png'},
            {text: 'Certainty Factor based Sum' , img : '/resources/images/flamingo/workflow/workflow-statistics.png'}
        ]
    },
    {
        category : 'datamining',
        text: message.msg('workflowdata.datamining'),
        list : [
            {text: 'Boolean Similarity/ Correlation' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Numeric Similarity/ Correlation' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'String Similarity' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'ID3 Classification' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'K-Means Clustering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'EM Clustering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'EM Clustering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'CF based Similarity' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Content based Similarity' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'User Similarity based Recommendation' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Item Similarity based Recommen' , img : '/resources/images/flamingo/workflow/workflow-minig.png'}
        ]
    },
    {
        category : 'mahout',
        text: message.msg('workflowdata.mahout'),
        list : [
            {text: 'Item-Based Collaborative Filtering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Factorized Recommendation' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Parallel ALS' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'k-Means Clustering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Fuzzy k-Means Clustering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Streaming k-Means Clustering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Cluster Quality Summarizer' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Sequence File To Sparse Vector' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Spectral k-Means Clustering' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Cluster Dump' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'To Sequence File' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Train Naive Bayes / CNaive Bayes' , img : '/resources/images/flamingo/workflow/workflow-minig.png'},
            {text: 'Test Naive Bayes / CNaive Bayes' , img : '/resources/images/flamingo/workflow/workflow-minig.png'}
        ]
    },
    {
        category : 'inmemory',
        text: message.msg('workflowdata.inmemory'),
        list : [
            {text: 'Apache Spark' , img : '/resources/images/flamingo/workflow/workflow-spark.png'}
        ]
    },
    {
        category : 'bpmn',
        text: message.msg('workflowdata.bpmn'),
        list : [
            {text: message.msg('workflowdata.bpmn.fork') , img : '/resources/images/flamingo/workflow/workflow-condition-if.png'},
            {text: message.msg('workflowdata.bpmn.join') , img : '/resources/images/flamingo/workflow/workflow-condition-end.png'},
            {text: message.msg('workflowdata.bpmn.confork') , img : '/resources/images/flamingo/workflow/workflow-pararell-process.png'},
            {text: message.msg('workflowdata.bpmn.conjoin') , img : '/resources/images/flamingo/workflow/workflow-pararell-end.png'},
            {text: message.msg('workflowdata.bpmn.sub') , img : '/resources/images/flamingo/workflow/workflow-sub.png'},
            {text: 'Bash Shell' , img : '/resources/images/flamingo/workflow/workflow-bash.png'},
            {text: 'R Script' , img : '/resources/images/flamingo/workflow/workflow-r.png'},
            {text: 'Python' , img : '/resources/images/flamingo/workflow/workflow-python.png'}
        ]
    }
];