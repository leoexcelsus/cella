# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Deleting all records from tables: users, polygons, industries, rules spatial domains and industry rules..."
puts "...if an error occur try 'rails db:drop db:create db:migrate db:seed...'"

User.delete_all
Polygon.delete_all
Industry.delete_all
Rule.delete_all
SpatialDomain.delete_all
IndustryRule.delete_all

puts "Deletion complete."

puts "Reading stringfied GeoJSONs..."

brasil = '{"type": "FeatureCollection","name": "brasilTerreste","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Brasil" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -59.835771554789254, 4.475461790825205 ], [ -67.375071356197068, 1.335695899192501 ], [ -73.180421708868352, -6.808707248563253 ], [ -69.289191622104823, -11.36732001315918 ], [ -61.729422508193004, -13.80635078518846 ], [ -56.71808623802351, -19.070285831802746 ], [ -54.678275562720074, -25.083301084408678 ], [ -56.87121646175494, -30.650255032871666 ], [ -52.689619500223266, -33.324666379938826 ], [ -48.416768262804347, -28.505740986401705 ], [ -47.584256981311619, -25.582702593186884 ], [ -41.691599321254927, -22.550997861711203 ], [ -38.628829185160598, -15.794226137224134 ], [ -37.90829946609184, -11.56336769785071 ], [ -34.321925919884663, -8.139160486264295 ], [ -34.561966486016424, -4.517657044266191 ], [ -42.286943731279521, -2.463159328246623 ], [ -49.384904235592565, 0.092672481534292 ], [ -50.746234725990917, 3.826359622442677 ], [ -54.077093710938186, 2.208808114729568 ], [ -57.060362747471466, 2.009107017773609 ], [ -59.161159042951013, 1.121713381376584 ], [ -59.835771554789254, 4.475461790825205 ] ] ] ] } }]}';
l11428 = '{"type": "FeatureCollection","name": "lei11428","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Área de Aplicação da Lei 11.428; Mata Atlântica" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -36.270239903985185, -5.203843152220545 ], [ -38.306747804908341, -7.014072397485572 ], [ -38.98558377188273, -10.4082522323575 ], [ -38.9290141079682, -11.030518535417356 ], [ -39.607850074942583, -12.444760133280658 ], [ -40.456395033660563, -14.254989378545686 ], [ -40.852382681062288, -18.10172652473387 ], [ -43.058599573729047, -20.817070392631415 ], [ -45.604234449882988, -21.269627703947677 ], [ -47.75388167863521, -22.00503333483659 ], [ -49.054983948669452, -23.984971571845215 ], [ -50.525795210447285, -26.078049136682907 ], [ -51.71375815265246, -27.379151406717149 ], [ -52.788581767028575, -28.510544685007787 ], [ -52.39259411962685, -29.924786282871089 ], [ -51.034922185678077, -30.999609897247204 ], [ -49.394401932156647, -30.037925610700157 ], [ -48.036729998207875, -27.492290734546209 ], [ -48.48928730952413, -26.021479472768377 ], [ -48.48928730952413, -25.795200817110249 ], [ -46.8487670560027, -24.38095921924694 ], [ -44.246562515934222, -23.192996277041765 ], [ -41.248370328464013, -22.401020982238315 ], [ -40.399825369746033, -21.382767031776737 ], [ -38.9290141079682, -18.158296188648407 ], [ -38.815874780139133, -15.442952320750861 ], [ -38.25017814099381, -12.840747780682383 ], [ -36.383379231814253, -10.634530888015631 ], [ -34.460010658720158, -8.484883659263408 ], [ -34.742858978292816, -5.543261135707736 ], [ -35.534834273096266, -5.034134160476947 ], [ -36.270239903985185, -5.203843152220545 ] ] ] ] } }]}';
goias = '{"type": "FeatureCollection","name": "goias","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Estado de Goiás: limites político-administrativos." }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -50.214662058917355, -12.543757045131088 ], [ -50.780358698062678, -13.448871667763601 ], [ -50.935925273827635, -14.764116353776473 ], [ -51.544049160908855, -15.202531249114097 ], [ -52.06731855211828, -16.008648959896178 ], [ -52.831009014964465, -16.560203183062868 ], [ -53.22699666236619, -17.536029885588547 ], [ -53.142142166494395, -18.328005180391997 ], [ -52.237027543861878, -19.00684114736638 ], [ -51.303628089272095, -19.544252954554437 ], [ -50.879355609913105, -19.544252954554437 ], [ -50.511652794468645, -18.978556315409115 ], [ -49.436829180092538, -18.58256866800739 ], [ -48.91355978888312, -18.39871726028516 ], [ -48.192296573972833, -18.384574844306528 ], [ -47.69731201472068, -18.441144508221058 ], [ -47.287181951340315, -18.059299276797965 ], [ -47.32960919927622, -17.465317805695381 ], [ -47.38617886319075, -16.970333246443225 ], [ -47.159900207532623, -16.645057678934666 ], [ -47.301324367318955, -16.178357951639775 ], [ -46.96190638383176, -15.824797552173949 ], [ -46.707342896216367, -15.216673665092729 ], [ -46.155788673049678, -14.820686017691006 ], [ -45.901225185434285, -14.56612253007561 ], [ -46.16993108902831, -13.646865491464464 ], [ -46.184073505006943, -12.953887108511445 ], [ -46.83462464002406, -13.208450596126841 ], [ -47.612457518848878, -13.491298915699501 ], [ -48.47514489354549, -13.137738516233675 ], [ -48.856990124968583, -12.812462948725116 ], [ -49.422686764113905, -12.869032612639648 ], [ -49.366117100199375, -13.335732339934538 ], [ -50.12980756304556, -12.911459860575548 ], [ -50.214662058917355, -12.543757045131088 ] ] ] ] } }]}';
tiXingu = '{"type": "FeatureCollection","name": "tiXingu","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Terra Indígena Parque do Xingu" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -53.12799975051577, -11.044660951395999 ], [ -54.03311437314828, -12.147769397729373 ], [ -53.891690213361947, -13.788289651250805 ], [ -52.87343626290037, -14.155992466695263 ], [ -51.855182312438792, -13.901428979079869 ], [ -51.54404916090887, -12.572041877088365 ], [ -52.307739623755054, -10.988091287481467 ], [ -53.12799975051577, -11.044660951395999 ] ] ] ] } }]}';
tq      = '{"type": "FeatureCollection","name": "tq","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Território Quilombola" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -43.299020645365815, -11.143657863246418 ], [ -43.893002116468409, -11.299224439011383 ], [ -44.076853524190639, -12.13362698175073 ], [ -43.63843862885301, -12.586184293066987 ], [ -43.412159973194882, -12.685181204917416 ], [ -42.973745077857259, -12.826605364703749 ], [ -42.66261192632733, -12.388190469366124 ], [ -42.577757430455534, -11.34165168694728 ], [ -43.299020645365815, -11.143657863246418 ] ] ] ] } }]}';
parnaJamanxim = '{"type": "FeatureCollection","name": "parnaJamaxim","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Parque Nacional do Jamanxim" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -55.758489122541505, -5.189700736241912 ], [ -56.20397522586844, -5.260412816135077 ], [ -56.45146750549452, -5.790753415333816 ], [ -56.253473681793658, -6.448375758340251 ], [ -55.8433436184133, -6.95750273357104 ], [ -55.192792483396182, -6.971645149549674 ], [ -55.079653155567115, -6.745366493891545 ], [ -54.74730638006924, -6.200883478714173 ], [ -54.796804835994458, -5.550332343697054 ], [ -55.348359059161147, -5.15434469629533 ], [ -55.758489122541505, -5.189700736241912 ] ] ] ] } }]}';
amazonas = '{"type": "FeatureCollection","name": "amazonas","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Estado do Amazonas: limites político-administrativos." }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -71.145437707294263, -4.383583025459837 ], [ -73.775927079319999, -6.731224077912918 ], [ -68.910935982670239, -9.107149962323266 ], [ -66.761288753918024, -9.842555593212182 ], [ -63.989375222105949, -8.739447146878806 ], [ -61.160892026379344, -8.711162314921541 ], [ -58.728396478054464, -8.852586474707874 ], [ -58.275839166738209, -7.15549655727191 ], [ -56.013052610156919, -2.573353780194809 ], [ -57.483863871934759, -1.555099829733232 ], [ -59.378947613071581, 0.085420423788198 ], [ -61.274031354208404, -0.961118358630644 ], [ -62.744842615986244, -1.045972854502443 ], [ -62.716557784028979, 1.160244038164309 ], [ -63.282254423174294, 2.348206980369483 ], [ -65.997598291071839, 0.79254122271985 ], [ -67.694688208507799, 2.291637316454951 ], [ -70.155468588789944, 1.810795173181428 ], [ -69.589771949644629, -0.140858231869929 ], [ -69.504917453772833, -2.06422680496402 ], [ -69.787765773345484, -3.648177394570919 ], [ -71.145437707294263, -4.383583025459837 ] ] ] ] } }]}';
cavernas = '{"type": "FeatureCollection","name": "cavernas","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Região de Cavernas" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -43.652581044831663, -12.968029524490079 ], [ -44.416271507677848, -13.024599188404611 ], [ -44.996110562801796, -14.148921258705936 ], [ -44.614265331378704, -15.244958497049996 ], [ -43.786933996628676, -15.683373392387621 ], [ -43.242450981451306, -15.485379568686758 ], [ -42.697967966273936, -14.601478570022193 ], [ -42.733324006220514, -13.286233884009322 ], [ -43.235379773461986, -13.010456772425979 ], [ -43.652581044831663, -12.968029524490079 ] ] ] ] } }]}';
sp = '{"type": "FeatureCollection","name": "sp","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Estado de São Paulo" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -48.079157246143808, -25.102222434157213 ], [ -47.230612287425828, -24.465813715118728 ], [ -46.594203568387343, -23.999113987823833 ], [ -45.84465552151979, -23.758692916187073 ], [ -45.293101298353108, -23.475844596614415 ], [ -44.840543987036853, -23.249565940956288 ], [ -44.557695667464188, -22.995002453340891 ], [ -44.69911982725052, -22.401020982238304 ], [ -45.194104386502673, -21.821181927114349 ], [ -45.745658609669363, -21.31205495188356 ], [ -46.45277940860101, -20.774643144695506 ], [ -47.357894031233528, -20.237231337507453 ], [ -48.022587582229278, -20.053379929785223 ], [ -48.77213562909683, -20.152376841635654 ], [ -49.56411092390028, -20.010952681849322 ], [ -50.158092395002868, -19.883670938041625 ], [ -50.865213193934515, -19.926098185977523 ], [ -51.487479496994368, -20.661503816866443 ], [ -51.925894392331998, -21.481763943627158 ], [ -52.378451703648253, -22.174742326580176 ], [ -53.02900283866537, -22.500017894088735 ], [ -52.42087895158415, -22.71215413376823 ], [ -50.723789034148183, -22.782866213661393 ], [ -50.115665147066963, -22.95257520540499 ], [ -49.394401932156683, -23.673838420315278 ], [ -49.13983844454129, -24.310247139353763 ], [ -48.729708381160933, -24.833516530563184 ], [ -48.079157246143808, -25.102222434157213 ] ] ] ] } }]}';
patriHist = '{"type": "FeatureCollection","name": "iphan","crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },"features": [{ "type": "Feature", "properties": { "name": "Iphan" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ [ -43.32023426933381, -19.600822618468968 ], [ -43.624296212874427, -19.73517557026598 ], [ -44.105138356147947, -20.010952681849325 ], [ -43.786933996628704, -20.788785560674143 ], [ -43.334376685312449, -20.901924888503206 ], [ -43.072741989707737, -20.378655497293785 ], [ -43.023243533782519, -20.046308721795906 ], [ -43.136382861611587, -19.728104362276664 ], [ -43.32023426933381, -19.600822618468968 ] ] ] ] } }]}';

puts "Building RGeo objects from stringfied GeoJSONs"

geom1 = RGeo::GeoJSON.decode(brasil)
geom2 = RGeo::GeoJSON.decode(l11428)
geom3 = RGeo::GeoJSON.decode(goias)
geom4 = RGeo::GeoJSON.decode(tiXingu)
geom5 = RGeo::GeoJSON.decode(tq)
geom6 = RGeo::GeoJSON.decode(parnaJamanxim)
geom7 = RGeo::GeoJSON.decode(amazonas)
geom8 = RGeo::GeoJSON.decode(cavernas)
geom9 = RGeo::GeoJSON.decode(sp)
geom10 = RGeo::GeoJSON.decode(patriHist)

puts "Creating 10 Polygons..."

polygon1 = Polygon.new(name: 'Brasil: limites territoriais terrestres', source: 'IBGE (2080)', geography: geom1[0].geometry)
polygon2 = Polygon.new(name: 'Área de aplicação da Lei 11.428/2006. Mata Atlântica', source: 'MMA (2080)', geography: geom2[0].geometry)
polygon3 = Polygon.new(name: 'Estado de Goiás: limites político-administrativos', source: 'IBGE (2080)', geography: geom3[0].geometry)
polygon4 = Polygon.new(name: 'Terra Indígena Parque do Xingu', source: 'FUNAI (2080)', geography: geom4[0].geometry)
polygon5 = Polygon.new(name: 'Território Quilombola', source: 'INCRA (2080)', geography: geom5[0].geometry)
polygon6 = Polygon.new(name: 'Parque Nacional do Jamanxim', source: 'ICMBio (2080)', geography: geom6[0].geometry)
polygon7 = Polygon.new(name: 'Estado do Amazonas: limites político-administrativos', source: 'IBGE (2080)', geography: geom7[0].geometry)
polygon8 = Polygon.new(name: 'Complexo de cavernas do oeste da Bahia e do norte de Minas Gerais', source: 'ICMBio (2080)', geography: geom8[0].geometry)
polygon9 = Polygon.new(name: 'Estado de São Paulo: limites político-administrativos', source: 'IBGE (2080)', geography: geom9[0].geometry)
polygon10 = Polygon.new(name: 'Complexo de Patrimônio Histórico em Minas Gerais', source: 'Iphan (2080)', geography: geom10[0].geometry)

puts "...saving polygons to database..."

polygon1.save!
polygon2.save!
polygon3.save!
polygon4.save!
polygon5.save!
polygon6.save!
polygon7.save!
polygon8.save!
polygon9.save!
polygon10.save!

puts "...polygons saved to database."

puts "Creating 2 Users..."
user1 = User.new(email:'admin@admin.com', first_name: 'Administrador', last_name: 'SPPI', company: 'Economy Ministry')
user1.password = '123456'

user2 = User.new(email:'ze@ze.com', first_name: 'José', last_name: 'da Silva', company: 'Silva Advogados Associados')
user2.password = '123456'

puts "...saving Users to database..."
user1.save!
user2.save!

puts "...Users saved to database."

puts "Creating 5 Industries..."
industry1 = Industry.new(name: 'Ferrovia')
industry2 = Industry.new(name: 'Rodovia')
industry3 = Industry.new(name: 'Mineração')
industry4 = Industry.new(name: 'Linha de transmissão')
industry5 = Industry.new(name: 'Geração de energia hidrelétrica')

puts "...saving Industries to database..."
industry1.save!
industry2.save!
industry3.save!
industry4.save!
industry5.save!

puts "...Industries saved to database."


puts "Creating 10 Rules..."
rule1 = Rule.new(
  jurisdiction: 'Federal',
  issuer: 'Congresso Nacional',
  category: 'Constituição Federal',
  number: 'n/a',
  pub_date: Date.strptime('05/10/1988', '%d/%m/%Y'),
  ed_date: Date.strptime('05/10/1988', '%d/%m/%Y'),
  long_title: 'sem ementa',
  hyperlink: 'http://www.planalto.gov.br/ccivil_03/constituicao/constituicao.htm',
  source: 'Página eletrônica, conforme endereço eltrônico exibido no hyperlink')
rule1.user = user1
rule1.polygons = [polygon1]
rule1.industries = [industry1, industry2, industry3, industry4, industry5]

rule2 = Rule.new(
  jurisdiction: 'Federal',
  issuer: 'Congresso Nacional',
  category: 'Lei Complementar',
  number: '140',
  pub_date: Date.strptime('09/12/2011', '%d/%m/%Y'),
  ed_date: Date.strptime('08/12/2011', '%d/%m/%Y'),
  long_title: 'Fixa normas, nos termos dos incisos III, VI e VII do caput e do parágrafo único do art. 23 da Constituição Federal, para a cooperação entre a União, os Estados, o Distrito Federal e os Municípios nas ações administrativas decorrentes do exercício da competência comum relativas à proteção das paisagens naturais notáveis, à proteção do meio ambiente, ao combate à poluição em qualquer de suas formas e à preservação das florestas, da fauna e da flora; e altera a Lei no 6.938, de 31 de agosto de 1981.',
  hyperlink: 'http://www.planalto.gov.br/ccivil_03/LEIS/LCP/Lcp140.htm',
  source: 'Página eletrônica, conforme endereço eltrônico exibido no hyperlink')
rule2.user = user1
rule2.polygons = [polygon1]
rule2.industries = [industry1, industry2, industry3, industry4, industry5]

rule3 = Rule.new(
  jurisdiction: 'Federal',
  issuer: 'Congresso Nacional',
  category: 'Lei',
  number: '11428',
  pub_date: Date.strptime('26/12/2009', '%d/%m/%Y'),
  ed_date: Date.strptime('22/12/2006', '%d/%m/%Y'),
  long_title: 'Dispõe sobre a utilização e proteção da vegetação nativa do Bioma Mata Atlântica, e dá outras providências.',
  hyperlink: 'http://www.planalto.gov.br/ccivil_03/LEIS/LCP/Lcp140.htm',
  source: 'Página eletrônica, conforme endereço eltrônico exibido no hyperlink')
rule3.user = user1
rule3.polygons = [polygon2]
rule3.industries = [industry1, industry2, industry3, industry4, industry5]

rule4 = Rule.new(
  jurisdiction: 'Estado',
  issuer: 'Assembléia Legislativa',
  category: 'Decreto',
  number: '1745',
  pub_date: Date.strptime('06/12/1979', '%d/%m/%Y'),
  ed_date: Date.strptime('06/12/1979', '%d/%m/%Y'),
  long_title: 'Aprova o Regulamento da Lei nº8544, de 17 de outubro de 1978, que dispõe sobre a prevenção e o controle da poluição do meio ambiente.',
  hyperlink: 'http://www.mp.go.gov.br/nat_sucroalcooleiro/Documentos/legislacao/especifica/03.pdf',
  source: 'Sítio eletrônico oficial do Ministério Público de Goiás')
rule4.user = user2
rule4.polygons = [polygon3]
rule4.industries = [industry1, industry2, industry3, industry4, industry5]

rule5 = Rule.new(
  jurisdiction: 'Federal',
  issuer: 'Ministério do Meio Ambiente, Ministério da Cultura, Ministério da Saúde, Ministério da Justiça',
  category: 'Portaria Interministerial',
  number: '60',
  pub_date: Date.strptime('24/03/2015', '%d/%m/%Y'),
  ed_date: Date.strptime('24/03/2015', '%d/%m/%Y'),
  long_title: 'Estabelece procedimentos administrativos que disciplinam a atuação dos órgãos e entidades da administração pública federal em processos de licenciamento ambiental de competência do Instituto Brasileiro do Meio Ambiente e dos Recursos Naturais Renováveis-IBAMA.',
  hyperlink: 'http://www.funai.gov.br/arquivos/conteudo/cglic/pdf/PORTARIA%20INTERMINISTERIAL%20No%2060.pdf',
  source: 'Sítio eletrônico oficial da Funai')
rule5.user = user1
rule5.polygons = [polygon4, polygon5, polygon6, polygon8, polygon10]
rule5.industries = [industry1, industry2, industry3, industry4, industry5]

rule6 = Rule.new(
  jurisdiction: 'Estado',
  issuer: 'Assembleia Legislativa',
  category: 'Lei',
  number: '3789',
  pub_date: Date.strptime('27/07/2012', '%d/%m/%Y'),
  ed_date: Date.strptime('27/07/2012', '%d/%m/%Y'),
  long_title: 'Dispõe sobre a reposição florestal no estado do Amazonas e dá outras providências.',
  hyperlink: 'https://sapl.al.am.leg.br/media/sapl/public/normajuridica/2012/8244/8244_texto_integral.pdf',
  source: 'Sítio eletrônico oficial da Assembleia Legislativa')
rule6.user = user1
rule6.polygons = [polygon7]
rule6.industries = [industry1, industry2, industry3, industry4, industry5]

rule7 = Rule.new(
  jurisdiction: 'Estado',
  issuer: 'Secretaria de Estado de Meio Ambiente',
  category: 'Resolução',
  number: '70',
  pub_date: Date.strptime('11/06/2018', '%d/%m/%Y'),
  ed_date: Date.strptime('11/06/2018', '%d/%m/%Y'),
  long_title: 'Dispõe sobre o licenciamento ambiental de intervenções destinadas à conservação e melhorias de rodovias, e sobre o Programa de Gerenciamento de Risco - PGR e o Plano de Ação de Emergência - PAE para transporte de produtos perigosos em rodovias.',
  hyperlink: 'http://www.mpsp.mp.br/portal/page/portal/cao_urbanismo_e_meio_ambiente/legislacao/leg_estadual/leg_est_resolucoes/Resol-SMA-070-2018_licenciamento-ambiental-em-faixa-de-dominio-de-rodovias.pdf',
  source: 'Sítio eletrônico oficial do Ministério Público de São Paulo')
rule7.user = user1
rule7.polygons = [polygon9]
rule7.industries = [industry2]

rule8 = Rule.new(
  jurisdiction: 'Federal',
  issuer: 'Conselho Nacional de Meio Ambiente',
  category: 'Resolução',
  number: '347',
  pub_date: Date.strptime('13/09/2004', '%d/%m/%Y'),
  ed_date: Date.strptime('10/09/2004', '%d/%m/%Y'),
  long_title: 'Dispõe sobre a proteção do patrimônio espeleológico.',
  hyperlink: 'https://www.icmbio.gov.br/cecav/images/stories/downloads/Legislacao/Res_CONAMA_347_2004.pdf',
  source: 'Sítio eletrônico oficial do ICMBio')
rule8.user = user2
rule8.polygons = [polygon8]
rule8.industries = [industry1, industry2, industry3, industry4, industry5]

rule9 = Rule.new(
  jurisdiction: 'Federal',
  issuer: 'Ministério do Meio Ambiente',
  category: 'Portaria',
  number: '421',
  pub_date: Date.strptime('26/10/2011', '%d/%m/%Y'),
  ed_date: Date.strptime('26/10/2011', '%d/%m/%Y'),
  long_title: 'Dispõe sobre o licenciamento e a regularização ambiental federal de sistemas de transmissão de energia elétrica e dá outras providências.',
  hyperlink: 'http://oads.org.br/leis/3542.pdf',
  source: 'Sítio eletrônico da Organização Ambiental para o Desenvolvimento Sustentável')
rule9.user = user1
rule9.polygons = [polygon1]
rule9.industries = [industry4]

rule10 = Rule.new(
  jurisdiction: 'Federal',
  issuer: 'Conselho Nacional do Meio Ambiente',
  category: 'Resolução',
  number: '479',
  pub_date: Date.strptime('27/04/2017', '%d/%m/%Y'),
  ed_date: Date.strptime('15/03/2017', '%d/%m/%Y'),
  long_title: 'Dispõe sobre o licenciamento ambiental de empreendimentos ferroviários de baixo potencialde impacto ambiental e a regularizaçãodos empreendimentos em operação.',
  hyperlink: 'https://www.in.gov.br/materia/-/asset_publisher/Kujrw0TZC2Mb/content/id/20183398/do1-2017-04-27-resolucao-n-479-de-15-de-marco-de-2017-20183239#:~:text=Disp%C3%B5e%20sobre%20o%20licenciamento%20ambiental,que%20lhe%20s%C3%A3o%20conferidaspelo%20art.',
  source: 'Sítio eletrônico da Imprensa Nacional')
rule10.user = user1
rule10.polygons = [polygon1]
rule10.industries = [industry1]

puts "...saving rules to database..."
rule1.save!
rule2.save!
rule3.save!
rule4.save!
rule5.save!
rule6.save!
rule7.save!
rule8.save!
rule9.save!
rule10.save!

puts "...rules saved to database."

puts "..."
puts "..."
puts "..."
puts "..."
puts "Seeding is finished! Good Luck!"
