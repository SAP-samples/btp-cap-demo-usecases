
## Notes for Blog Post    
<br />

## **_Introduction_**

`Query Language` is an essential tool to communicate with a database to perform operations such as retrieving data, inserting data, updating data and deleting data. Query languages are designed to be `concise and efficient`, allowing users to specify complex operations with minimal effort. There are several types of query languages, including structured query language (SQL), which is the most common query language used in relational databases, and non-relational query languages such as MongoDB's query language.

Simillarly SAP Cloud Application Programming Model provides a query language called `CDS Query Language` (in short `CQL`). In this blog post, I will try to explain my understandings and learnings about CQL. Let's get started!!    
<br />     

## **_Query Styles_**

Primarily there are two ways or styles to construct and execute queries.    
`1. SQL-Like fluent API` provided by `cds.ql`   
`2. Querying API` provided by `cds.service`

Let's look at an example    
Fluent API | Querying API
-----------|--------------
```result = await SELECT.from(Roots).where({ID:'38a13fed-f2d1-45bd-91ec-642053889c92'});``` | ```result = await srv.read(Roots).where({ID:'38a13fed-f2d1-45bd-91ec-642053889c92'});``` <br/>  ```result = await cds.read(Roots).where({ID:'38a13fed-f2d1-45bd-91ec-642053889c92'});```
```input = {name: 'root 6',descr: 'descr 6',dfield: '2023-02-11',tfield: '14:18:29',dtfield: '2022-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 290,afield: 23891100.123456};``` <br /> <br /> ```result = await INSERT.into(Roots).entries(input);```|```input = {name: 'root 6',descr: 'descr 6',dfield: '2023-02-11',tfield: '14:18:29',dtfield: '2022-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 290,afield: 23891100.123456}; ``` <br /> <br /> ```result = await cds.create(Roots).entries(input);``` <br /> ```result = await srv.create(Roots).entries(input);```
 |

**_`Points to Note`_**:   
1. srv.read and cds.read  - these methods are actually convenient shortcuts to the respective fluent API methods.    
2. In above example Roots is the entity and often referred as query target.It is recommended to use entity definitions reflected from a service’s model to construct queries instead of fully qualified enitty names with namespace. By utilizing this reflection technique, code can be simplified significantly as it eliminates the need to repeatedly include namespaces throughout the codebase.      

    using fully qualified entity names | using reflected entity definition     
    -----------|--------------
    ```result = await SELECT.from('cap.cql.db.Roots') ```| ```const {Roots} = cds.entities;```  <br /> ``` result = await SELECT.from(Roots);```
    |

3. In all above mentioned api styles, arguments like columns of entity can be passed in multiple ways as shown below:
    ```js
    // tagged template string
    result = await SELECT.from `cap.cql.db.Roots` .columns `name, descr as description`

    // cql column expressions
    const { Roots } = cds.entities;
    result = await SELECT.from (Roots) .columns ('name', 'descr as description')

    // cqn expression objects
    result = await SELECT.from `cap.cql.db.Roots` .columns ({ref:['name']}, {ref:['descr'], as:'description'})

    // array of columns
    result = await SELECT.from `cap.cql.db.Roots` .columns (['name', 'descr as description'])

    // projection function
    result = await SELECT.from `cap.cql.db.Roots` .columns (r => { r.name, r.descr.as('description') }); 
    ```    
4. _Projection functions are the recommended way_ as it supports nested projections aka expands, uses standard JavaScript constructs, offers type inference and code completion etc.      
<br />

## **_Retrieve Data: SELECT query examples_**    

1. **_Retrieve full table data_**
    ```js
    result = await SELECT.from(Roots);
    ``` 
2. **_Retrieve single entry by one or more key_**
    ```js
    // one key
    result = await SELECT.from(Roots).byKey('38a13fed-f2d1-45bd-91ec-642053889c92');
    result = await SELECT.from(Roots, '38a13fed-f2d1-45bd-91ec-642053889c92');

    // more than one key
    result = await SELECT.from(Roots2).byKey({first: 101, second:201});
    result = await SELECT.from(Roots2, {first: 101, second:201});
    ```
3. **_Retrieve data by one or more non-key field_**
    ```js
    // string field
    result = await SELECT.from(Roots).where({name:'root 1'});
    result = await SELECT.from(Roots).where(`name like '%1%'`);
    result = await SELECT.from(Roots).where({category:{in:['rc1', 'rc2']}})

    // date field
    result = await SELECT.from(Roots).where({dfield:'2022-02-11'});
    result = await SELECT.from(Roots).where(`dfield < '2022-06-11'`);

    // time field
    result = await SELECT.from(Roots).where({tfield:'04:08:29'});
    result = await SELECT.from(Roots).where({tfield:{'>':'14:08:29'}});

    // datetime or timestamp field
    result = await SELECT.from(Roots).where(`dtfield < '2022-06-01T14:08:29Z'`);
    result = await SELECT.from(Roots).where(`tsfield > '2022-10-01T04:08:29.000Z'`);

    // numeric or amount field
    result = await SELECT.from(Roots).where(`nfield between 1 and 500`);
    result = await SELECT.from(Roots).where({nfield:{ between: 501, and: 1000}});
    result = await SELECT.from(Roots).where(`afield < 299345.451`);

    // more than one non-key field
    result = await SELECT.from(Roots).where({and: {dfield:'2022-10-01', nfield:123}});
    result = await SELECT.from(Roots).where(`dfield > '2022-10-01' and nfield > 500`);
    result = await SELECT.from(Roots).where({and:{ dfield:{'>': '2022-10-01'}, nfield:{'>':600} }});
    ```
4. **_Retrieve data by multiple conditions_**
    ```js
    result = await SELECT.from(Roots).where(`nfield > 900 or nfield < 200`);
    result = await SELECT.from(Roots).where({or:{ nfield:{'>': 900}, nfield:{'<':200} }});
    ```
5. **_Retrieve only few columns_**
    ```js
    result = await SELECT.from(Roots).columns(['name','descr'])
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr})
    result = await SELECT.from(Roots).where({name:{ like: '%root%'}})
    ```
6. **_Retrieve associated and composition entity data_**
    ```js
    // getting few column of associated and composition entity
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.asitem(asi=>{asi.asi_sfield}) })
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.csitem(csi=>{csi.csi_sfield}) })

    // getting all columns of associated and composition entity
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.asitem(asi=>{asi`.*`}) })
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.csitem(csi=>{csi`.*`}) })
    

    // getting all columns of root and associated entity
    result = await SELECT.from(Roots).columns(r=>{r`.*`,r.asitem(asi=>{asi`.*`}) })
    resutl = await SELECT.from(Roots).columns(r=>{r`.*`,r.amitems(ami=>{ami`.*`}) })
    result = await SELECT.from(Roots).columns(r=>{r`.*`,r.csitem(csi=>{csi`.*`}) })
    resutl = await SELECT.from(Roots).columns(r=>{r`.*`,r.cmitems(cmi=>{cmi`.*`}) })

    // mix and match
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.asitem(asi=>{asi.asi_nfield}), r.amitems(ami=>{ami`.*`}) })
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.csitem(csi=>{csi`.*`}), r.cmitems(cmi=>{cmi.csm_nfield}) })

    //Use filter
    result = await SELECT.from `${Roots}[category='rc1']`
    result = await SELECT.from `${Roots}[category='rc1' and name like '%root%']`
    result = await SELECT.from(Roots).columns(r=>{ r`.*`,r.amitems`[asm_nfield > 1010]`(ami=>{ami`.*`}) })
    ```
    **_`Note`_**: Not every CQL or SQL statement can be expressed with projection functions. This is where tagged template strings kick in.   
    **_`Note`_**: Template string and special character * is used to get all columns as shown above: ``` r.`*` ```     
    **_`Note`_**: Inflix filters are used to filter data. In last example, both template string and inflix filter are used to apply filter on child items: ``` r.amitems`[asm_nfield > 1010]`(ami=>{ami`.*`}) ```    
        
7. **_Retrieve one or distinct entry_**
    ```js
    //get one entry
    result = await SELECT.one.from(Roots).where({category:'rc1'})
    resutl = await SELECT.one.from(Roots).columns(r=>{r`.*`,r.amitems(ami=>{ami`.*`}) })

    //get distinct entry
    result = await SELECT.distinct.from(Roots).columns('category').where({nfield:{'>':500}})
    ```
8. **_Using functions and expressions_**
    ```js
    result = await SELECT.from(Roots).columns(`count(*) as totalrows`) 
    result = await SELECT.one.from(Roots).columns(`count(*) as totalcount`, `sum(CASE WHEN nfield < 500 THEN 1 END) as lowcount`, `sum(CASE WHEN nfield >= 500 THEN 1 END) as highcount`)
    result = await SELECT.one.from(Roots).columns(`avg(nfield) as average`)
    result = await SELECT.one.from(Roots).columns(`min(nfield) as minimum`)
    result = await SELECT.one.from(Roots).columns(`max(nfield) as maximum`)
    result = await SELECT.from(Roots).columns(`concat(name, ' ',descr) as name`, `length(name) as charcount`)
    result = await SELECT.from(Roots).columns(`toupper(name) as name`, `tolower(descr) as descr`)
    result = await SELECT.from(Roots).columns(`year(dfield) as year`, `month(dfield) as month`, `day(dfield) as day`)
    result = await SELECT.from(Roots).columns(`hour(tfield) as hour`, `minute(tfield) as minute`, `second(tfield) as second`)
    result = await SELECT.from(Roots).columns(`ceiling(afield) as afield`)
    ```
9. **_Group By and Order By_**   
    ```js
    result = await SELECT.from(Roots).columns(`category`, `count(name) as itemscount`).groupBy('category');
    result = await SELECT.from(Roots).columns('category','name','descr').orderBy('category desc', 'name asc');
    result = await SELECT.from(Roots).columns(`name`).orderBy('name desc');
    result = await SELECT.from(Roots).columns(`name`, `count(amitems.asm_sfield) as itemscount`).groupBy('name')            //HANA
    result = await SELECT.from(Roots).columns(`name`, `asitem.asi_sfield`).orderBy('asitem.asi_sfield desc')                //HANA
    result = await SELECT.from(Roots).columns(`name`,`asitem.asi_sfield`).orderBy('asitem.asi_sfield asc', 'name desc')     //HANA
    ```
10. **_Limit by rows and offset_**    
    ```js
    // Only 2 entries are fetched
    result = await SELECT.from(Roots).limit(2).where(`name like '%root%'`)

    // Only 2 rows are fetched after 3 rows (offset)
    result = await SELECT.from(Roots).limit(2,3).where(`name like '%root%'`)
    ```

## **_Create Data: INSERT query examples_**     

1. **_Examples with Different Entities, Associations, Compositions_**
    ```js
    // create one entry
    onerowdata = {name:'root 6', descr:'descr 6', dfield: '2022-04-12',tfield: '04:08:29',dtfield: '2022-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 200,afield: '23891100.123456',category: 'rc3'};
    result = await INSERT.into(Roots).entries(onerowdata);

    // create one entry with associated entry
    onerowdata = {name:'root 7', descr:'descr 7', dfield: '2023-04-12',tfield: '14:08:29',dtfield: '2023-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 200,afield: '23891100.123456',category: 'rc3', asitem_ID:'585dee53-69e5-47d9-b90d-945253d4af0d'};
    result = await INSERT.into(Roots).entries(onerowdata);

    onerowdata = {name:'root 7', descr:'descr 7', dfield: '2023-04-12',tfield: '14:08:29',dtfield: '2023-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 200,afield: '23891100.123456',category: 'rc3', amitems:[{ID:'110f6a9f-b647-4e63-bdb2-03ec724d0d2b'},{ID: '71bd1b1d-ca9c-403e-b435-99e58e8373c0'}]};
    result = await INSERT.into(Roots).entries(onerowdata);

    // create one entry with composition entry
    onerowdata = {name:'root 8', descr:'descr 8', dfield: '2023-04-12',tfield: '14:08:29',dtfield: '2023-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 200,afield: '23891100.123456',category: 'rc3', csitem:{csi_sfield:'csi field 7', csi_nfield:'700'}};
    result = await INSERT.into(Roots).entries(onerowdata);

    onerowdata = {name:'root 9', descr:'descr 9', dfield: '2023-01-12',tfield: '10:58:29',dtfield: '2023-12-11T04:08:29Z',tsfield: '2022-09-11T04:08:29.129Z',nfield: 400,afield: '13892100.723456',category: 'rc2', cmitems:[{csm_sfield:'csm field 01', csm_nfield:'100'}, {csm_sfield:'csm field 02', csm_nfield:'200'}]};
    result = await INSERT.into(Roots).entries(onerowdata);

    // create multiple entry
    let multiplerowdata = [{name:'root 20', descr:'descr 20', dfield: '2023-01-10',tfield: '18:08:29',dtfield: '2023-02-11T04:08:29Z',tsfield: '2023-02-11T04:08:29.129Z',nfield: 400,afield: '23891100.123456',category: 'rc3'}, {name:'root 21', descr:'descr 21', dfield: '2023-04-12',tfield: '16:08:29',dtfield: '2023-02-11T04:08:29Z',tsfield: '2023-01-11T04:08:29.129Z',nfield: 300,afield: '23891100.123456',category: 'rc3'}];
    result = await INSERT.into(Roots).entries(multiplerowdata);
    ```
2. **_Different Variations_**
    ```js
    // using columns and values
    result = await INSERT.into(Roots).columns('name','descr','dfield','tfield','dtfield','tsfield','nfield','afield','category').values('root 10','descr 10','2022-04-12','04:08:29','2022-02-11T04:08:29Z','2022-02-11T04:08:29.129Z',200,23890.456,'rc3');

    // using columns and rows
    result = await INSERT.into(Roots).columns('name','descr','dfield','tfield','dtfield','tsfield','nfield','afield','category').rows(['root 11','descr 11','2023-04-12','04:08:29','2022-02-11T04:08:29Z','2022-02-11T04:08:29.129Z',200,23890.456,'rc3'], ['root 12','descr 12','2023-04-12','04:08:29','2022-02-11T04:08:29Z','2022-02-11T04:08:29.129Z',200,23890.456,'rc2'], ['root 13','descr 13','2023-01-12','04:08:29','2022-02-11T04:08:29Z','2022-02-11T04:08:29.129Z',300,23890.456,'rc1']);
    ```

## **_Upsert Data: Create or Modify Data query examples_**     

1.  **_Different Variations_**
    ```js
    // create entry
    result = await UPSERT.into(Roots).entries({name:'root 6', descr:'descr 6', dfield: '2022-04-12',tfield: '04:08:29',dtfield: '2022-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 200,afield: '23891100.123456',category: 'rc3'})

    // create entry with association
    result = await UPSERT.into(Roots).entries({name:'root 7', descr:'descr 7', dfield: '2023-04-12',tfield: '14:08:29',dtfield: '2023-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 200,afield: '23891100.123456',category: 'rc3', asitem_ID:'585dee53-69e5-47d9-b90d-945253d4af0d'})

    // modify entry
    result = await UPSERT.into(Roots).entries({name:'root 11',ID:'7891fd0d-5924-471a-89c4-519f7df071b8'});
    result = await UPSERT.into(Roots).entries({name:'root 66', descr:'descr 6', dfield: '2022-04-12',tfield: '04:08:29',dtfield: '2022-02-11T04:08:29Z',tsfield: '2022-02-11T04:08:29.129Z',nfield: 200,afield: '23891100.123456',category: 'rc2', ID:'7891fd0d-5924-471a-89c4-519f7df071b87'})

    // modify root entry with creation of composed entry: Not working
    result = await UPSERT.into(Roots).entries({ID: '7891fd0d-5924-471a-89c4-519f7df071b8', descr: 'descr 1111', amitems: [{asm_sfield: 'asm string 1111',asm_nfield: 1001,root_ID: '7891fd0d-5924-471a-89c4-519f7df071b8'}]})
    ```
## **_Update Data query examples_**    
- When update query executes successfully, it returns no of rows updated by the query. 
- If all keys are passed as part of query then only one entry of the entity is updated.
- Method .set and .with are aliases to the same method.
1. **_Using Set or With_**
    ```js
    // by single key
    result = await UPDATE.entity(Roots, 'f11aacb1-ab35-40da-918b-589cdd387ad1').set({name:'root 333'});
    result = await UPDATE.entity(Roots, 'f11aacb1-ab35-40da-918b-589cdd387ad1').set({name:'root 332',dfield: '2021-12-20'});
    result = await UPDATE.entity(Roots, 'f11aacb1-ab35-40da-918b-589cdd387ad1').set({nfield: {'-=': 89}});
    result = await UPDATE.entity(Roots, 'f11aacb1-ab35-40da-918b-589cdd387ad1').set(`nfield = nfield * 2`)

    // by multiple key
    result = await UPDATE.entity(Roots2,{first:101,second:201}).set({name:'r2 name1 extra'});

    // by cqn expression
    result = await UPDATE.entity(Roots2,{first:102,second:202}).with({descr: {xpr: [{ref:['descr']}, '||', {val:'Additional Description'}]}})

    // by functions with template string
    result = await UPDATE.entity(Roots, 'f11aacb1-ab35-40da-918b-589cdd387ad1').set(`descr = concat('descr',' add')`);
    result = await UPDATE.entity(Roots2, {first:102,second:202}).set(`descr = concat('descr',' add'), name = 'root 33'`);

    // by where clause
    result = await UPDATE.entity(Roots).set({nfield: {'-=': 89}}).where({nfield:{'>':500}});
    result = result = await UPDATE.entity(Roots2).set({name: 'r2 name2 new'}).where(`descr like '%Add%' and first = 102`);
    ```
## **_Delete Data query examples_**   
1.  **_Different Variations_**
    ```js
    // using one or more key
    result = await DELETE.from(Roots,'445b1357-90b2-4a2c-a60d-7f7e40d46f12');
    result = await DELETE.from(Roots2,{first:101, second:201});

    // using where condition
    result = await DELETE.from(Roots).where({category:'rc1'});
    result = await DELETE.from(Roots2).where({first:101})
    result = await DELETE.from(AssocMItems).where({asm_nfield:{'>=':1014}});
    ```
<br />
<br />
<br />     


1. Only Works in HANA (Not in Sqlite). [Yet to try using better sqlite]
    ```js
    result = await SELECT.from(Roots).columns('name',`asitem.asi_sfield`)
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.asitem.asi_sfield })
    result = await SELECT.from(Roots).columns(r=>{r.name, r.descr, r.amitems.asm_sfield })
    result = await SELECT.from(Roots).where(`asitem.asi_nfield > 100`)
    cat = ['rc1', 'rc3']; result = await SELECT.from(Roots).where `category in ${cat} and amitems.asm_nfield > 1000`
    ```


## **_Commands to Try Queries_**    

1. **_Test Locally with Sqlite_**
    ```cmd   
    npm install
    cds deploy --to sqlite
    cds repl
    await cds.test()
    const {Roots, AssocSItems, AssocMItems, CompSItems, CompMItems, Roots2} = cds.entities
    //Then above queries can be executed
    ```
2. **_Test with Hana Container Running on BTP_**
    ```cmd
    npm install
    cds add hana --for hybrid
    cf login
    cds deploy --to hana:cap-cql-examples-db --profile hybrid --store-credentials
    cds repl --profile hybrid
    await cds.test()
    const {Roots, AssocSItems, AssocMItems, CompSItems, CompMItems, Roots2} = cds.entities
    //Then above queries can be executed
    ```
3. **_Test locally with Better Sqlite_**
    ```cmd
    npm install
    npm add @cap-js/sqlite -D 
    jq '.cds = {requires:{db:"sql"}}' package.json > temp.json && mv temp.json package.json
    cds repl
    await cds.test()
    const {Roots, AssocSItems, AssocMItems, CompSItems, CompMItems, Roots2} = cds.entities
    //Then above queries can be executed
    ```