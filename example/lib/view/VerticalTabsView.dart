import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' hide TabBarIndicatorSize;
import 'package:flutter/material.dart' hide TabBarIndicatorSize;
import 'package:flutter_components/utils/Gaps.dart';
import 'package:flutter_components/widgets.dart';
import 'package:flutter_components_example/widget/TitleWidget.dart';

class VerticalTabsView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _VerticalTabsViewState();
  }


}

class _VerticalTabsViewState extends State<VerticalTabsView> {

  final List<Map> data = [
    {
      "name": "热门推荐",
      "children": [
        {
          "name": "热门分类",
          "children": [
            {
              "name": "空调",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/117080/5/10502/18158/5ef0103eE416ae569/898a7ac882ba6c63.jpg"
            },
            {
              "name": "冰箱",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t1/119891/13/5448/24096/5ef01048E096cfd33/260803efca5e8a73.jpg"
            },
            {
              "name": "电脑",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t1/131424/31/274/19042/5ecb3bc2E96ef8448/0188085e6fd6cd12.png"
            },
            {
              "name": "手机",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t27136/183/1628977274/31007/a6f7ed55/5be6ebd8Nb07ef492.png"
            },
            {
              "name": "全面屏手机",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t1/86638/37/11918/19572/5e3e4307E7606f742/0210ac72c0d9275e.jpg"
            },
            {
              "name": "游戏手机",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t1/102972/19/11837/14987/5e3d8bdaEc8ffe21e/6119d3f773fcdacd.jpg"
            },
            {
              "name": "保健品",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t1/134182/23/366/16758/5eccb3caE2b8d0c6d/7ab40f9d9441a2a5.jpg"
            },
            {
              "name": "口罩",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t1/114862/21/8081/13361/5ecb398fEc7c98869/4b4101d0acbf4ced.jpg"
            },
            {
              "name": "驱蚊用品",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t1/136893/38/305/31308/5ecb84dcE410bc59a/36568e70a84f8807.jpg"
            },
            {
              "name": "电磁炉",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t1/120301/21/3027/11815/5ecb80a8Ed94ec15d/c20f3541c5618e17.jpg"
            },
            {
              "name": "电热水壶",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t1/111738/8/8168/9785/5ecb40ccE19924aec/1a1a91827d0f07ba.jpg"
            },
            {
              "name": "数据线",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/113143/20/8135/9835/5ecb81ccE22407538/e9a80b7af28e83a6.jpg"
            }
          ]
        }
      ]
    },
    {
      "name": "手机数码",
      "children": [
        {
          "name": "热门品牌",
          "children": [
            {
              "name": "小米",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t13411/188/926813276/3945/a4f47292/5a1692eeN105a64b4.png"
            },
            {
              "name": "华为",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t11929/135/2372293765/1396/e103ec31/5a1692e2Nbea6e136.jpg"
            },
            {
              "name": "荣耀",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t12178/348/911080073/4732/db0ad9c7/5a1692e2N6df7c609.jpg"
            },
            {
              "name": "iPhone",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t13759/194/897734755/2493/1305d4c4/5a1692ebN8ae73077.jpg"
            },
            {
              "name": "vivo",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t11014/359/2341377211/2777/1755c29c/5a169244Nff0179e0.png"
            },
            {
              "name": "OPPO",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t13036/273/932026474/2570/a3517c7d/5a169254N4bbbd9fb.png"
            },
            {
              "name": "魅族",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t12820/326/909017718/7138/68cde747/5a169243N40eca33c.jpg"
            },
            {
              "name": "三星",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t11509/131/2348573811/3425/4f20fe6/5a16925aN8a6dfd03.png"
            },
            {
              "name": "一加",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t11209/71/2351231464/4158/fc0c415c/5a16923fNfc14307e.jpg"
            },
            {
              "name": "360手机",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t13096/309/908035611/5138/5558f001/5a16924fNeac7677e.jpg"
            },
            {
              "name": "锤子手机",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t1/84715/12/13703/4118/5e5f0dacE08741f12/63fb9e75fbaf0738.jpg"
            },
            {
              "name": "努比亚",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/108301/34/7712/3254/5e5f0de9E4ca2f4b5/c664966ee1d36d47.jpg"
            }
          ]
        },
        {
          "name": "手机通讯",
          "children": [
            {
              "name": "老人机",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t11461/339/2354953633/8254/8c8c50d3/5a169217N5d1b842e.jpg"
            },
            {
              "name": "手机",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t27136/183/1628977274/31007/a6f7ed55/5be6ebd8Nb07ef492.png"
            },
            {
              "name": "全面屏手机",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t1/86638/37/11918/19572/5e3e4307E7606f742/0210ac72c0d9275e.jpg"
            },
            {
              "name": "游戏手机",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t1/102972/19/11837/14987/5e3d8bdaEc8ffe21e/6119d3f773fcdacd.jpg"
            },
            {
              "name": "拍照手机",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t12022/66/917351804/2257/7ddc58e5/5a169232Ndf76f53c.jpg"
            }
          ]
        }
      ]
    },
    {
      "name": "家用电器",
      "children": [
        {
          "name": "厨房小电",
          "children": [
            {
              "name": "电压力锅",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t13069/193/944900508/2525/d7c9efc/5a17f21dN905aaf4c.jpg"
            },
            {
              "name": "热水壶/热水瓶",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t12559/262/969294499/3436/8c0ce9c9/5a17f1d2N8078d5e6.jpg"
            },
            {
              "name": "电饭煲",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t14185/134/950962305/3800/eb1bafb8/5a17f224Nea1d3f59.jpg"
            },
            {
              "name": "电磁炉",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t11209/197/2422417970/2811/d167e855/5a17f1edN56abbe6e.jpg"
            },
            {
              "name": "微波炉",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t13267/86/981023661/1871/6fae5f11/5a17f203N50016f64.jpg"
            }
          ]
        },
        {
          "name": "冰箱",
          "children": [
            {
              "name": "全部",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t14047/217/992011228/3503/5b1fa21a/5a17f699N94996c85.jpg"
            },
            {
              "name": "双门冰箱",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t13153/44/964603695/1011/21d660d2/5a17f6aeN280056ea.jpg"
            },
            {
              "name": "对开门冰箱",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t13588/266/943842715/1088/c4ae40e4/5a17f6c5Ne56d7e26.jpg"
            },
            {
              "name": "十字门冰箱",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t13711/311/977302673/2235/1a734ffc/5a17f6caNd7a7e0aa.jpg"
            },
            {
              "name": "三门冰箱",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t12247/42/992183546/1010/e5504689/5a17f6aeN47ef140c.jpg"
            },
            {
              "name": "单门冰箱",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t13180/287/985506867/3709/3aab0a22/5a17f6aeN55f73ab4.jpg"
            },
            {
              "name": "多门冰箱",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t14092/321/992718608/844/c060eb1/5a17f6c0N8cf0d399.jpg"
            }
          ]
        },
        {
          "name": "洗衣机",
          "children": [
            {
              "name": "波轮洗衣机",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t7927/184/4204864436/1170/5c6edbfd/5a17f6e7Nd3e178e9.jpg"
            },
            {
              "name": "滚筒洗衣机",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t12481/129/1018625238/1840/43d49869/5a17f6eaN9ec936de.jpg"
            },
            {
              "name": "全部",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t11683/55/2479822092/6785/8133604c/5a17f6d4Ne2a84dc3.jpg"
            },
            {
              "name": "洗烘一体机",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t11596/353/2418450536/1557/950e51b6/5a17f6d9Nd153842e.jpg"
            },
            {
              "name": "迷你洗衣机",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t13951/348/993649154/1944/da120406/5a17f6f4N217289e8.jpg"
            }
          ]
        }
      ]
    },
    {
      "name": "美妆护肤",
      "children": [
        {
          "name": "当季主推",
          "children": [
            {
              "name": "防晒",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t1/99405/15/13851/8331/5e5f2520E633cbaac/4ff37f307da08084.jpg"
            },
            {
              "name": "控油",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t19291/98/2577005836/12222/7107fb29/5afd3cc9N3add85ae.jpg"
            }
          ]
        },
        {
          "name": "拔草推荐",
          "children": [
            {
              "name": "明星同款面膜",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t1/91206/20/13565/9379/5e5f262bE45790537/0373287c48fa2317.jpg"
            },
            {
              "name": "显白口红",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t1/95022/3/13977/20829/5e5f2636E20222316/bbc6e2cf5b10669e.jpg"
            },
            {
              "name": "小美盒",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t1/102819/1/13751/13266/5e5f2642Ea72e3802/828ddc1e738c1e07.jpg"
            }
          ]
        },
        {
          "name": "潮流速递",
          "children": [
            {
              "name": "新品速递",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t1/85282/32/13974/33702/5e5f272cE97839976/3b5ccf856f171658.jpg"
            },
            {
              "name": "精选礼盒",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/87029/15/13883/14372/5e5f273dEf7bfadc5/6a5aff8eeb02f29b.jpg"
            },
            {
              "name": "潮流风向",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t1/107675/23/7620/26234/5e5f2767E01a2b3d2/3867634f9d2a4e88.jpg"
            }
          ]
        }
      ]
    },
    {
      "name": "个护清洁",
      "children": [
        {
          "name": "畅销推荐",
          "children": [
            {
              "name": "个护馆",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t21343/109/200166835/32189/655b48ef/5b03c73fN69e0c2b7.jpg"
            },
            {
              "name": "清洁馆",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t22015/174/193799214/56285/64f190df/5b03bf93Na049c54e.jpg"
            },
            {
              "name": "进口清洁",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t20482/61/128269126/48485/836a6d71/5afd574eNb1ad35ae.jpg"
            },
            {
              "name": "卫生棉条",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t18214/1/2613174758/15599/5ed2de47/5afd5747N2fc58c3e.jpg"
            },
            {
              "name": "湿厕纸",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t20365/251/116787241/43845/fa0bc54d/5afd5740Na342fa77.jpg"
            },
            {
              "name": "花露水",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t22123/187/137040009/6892/6b0cbf68/5afd572dN7ed9c341.jpg"
            },
            {
              "name": "驱蚊用品",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t20293/233/118774843/46835/4e4eaf16/5afd5727N9f7271c7.jpg"
            },
            {
              "name": "本色纸",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t17062/178/2600012755/33321/1ad5ca0b/5afd571fN18ed0cd5.jpg"
            },
            {
              "name": "免洗洗手液",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t16840/96/2521969144/9603/65ca0871/5afd571aN43e80da5.jpg"
            },
          ]
        }
      ]
    },
    {
      "name": "汽车生活",
      "children": [
        {
          "name": "热卖推荐",
          "children": [
            {
              "name": "机油",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t12934/187/1360887703/3624/2773362c/5a1fb8f6N7d4de465.jpg"
            },
            {
              "name": "汽车坐垫",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t13861/165/1416050485/4023/7a99270b/5a1fb902N806b102c.jpg"
            },
            {
              "name": "洗车水枪",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t12775/362/1793763591/8646/9054789/5a28b10cN62861b9b.jpg"
            },
            {
              "name": "行车记录仪",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t12901/240/1394851486/8943/454985f7/5a1fb8fcNb81047cc.jpg"
            },
            {
              "name": "轮胎",
              "image": "https://img20.360buyimg.com/focus/s140x140_jfs/t12508/203/1731926315/5258/efc05e60/5a28b101Ne8ebee02.jpg"
            },
            {
              "name": "应急救援",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t15556/93/149991245/6163/3387b1e9/5a28b106N59344f7a.png"
            },
          ]
        },
        {
          "name": "乘用车",
          "children": [
            {
              "name": "全部车型",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t1/94052/26/18882/8021/5e966cb2E7c1e4362/d0c7c9448a685905.png"
            },
            {
              "name": "二手车",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t1/96639/11/18765/10438/5e966ce9E27a1c056/4b72cfdbfb44651a.png"
            },
            {
              "name": "选车攻略",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t1/100084/6/18603/6955/5e966d09Ecf19bd09/e5a4be6abf32c726.png"
            },
            {
              "name": "热销轿车",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/97114/26/18674/12326/5e966d21E1e9c5592/1ed7cfbf11ead598.png"
            },
            {
              "name": "热门SUV",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/113567/22/1272/13352/5e966d2fEe2452b62/5082cad35c4d5a08.png"
            },
            {
              "name": "精选MPV",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/105027/24/18794/13475/5e966d44E4b44c097/d94401a5b353783d.png"
            },
            {
              "name": "豪华车",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t1/117151/20/1227/12606/5e966d51Eef09370c/0d158b551cb3082f.png"
            },
            {
              "name": "新能源",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/107285/10/12401/12715/5e966d61Ea8135a01/f6038997c3649d53.png"
            },
            {
              "name": "试驾有礼",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t1/111461/37/1287/13130/5e966d73E459e5141/eaf1d076c5c769cc.png"
            },
            {
              "name": "12万以下",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t1/101246/3/18767/13809/5e966d83E917e056c/bfd8712cfaf1de76.png"
            },
            {
              "name": "12-25万",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t1/86764/19/18697/14390/5e9670b0E16edd137/11df9c73cf4171d2.png"
            },
            {
              "name": "25万以上",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t1/106063/26/18704/13467/5e966e3eE036b0383/48c5c0476d0cbd4b.png"
            },
            {
              "name": "经济代步",
              "image": "https://img11.360buyimg.com/focus/s140x140_jfs/t1/101722/30/18693/13606/5e966daeEe466eb09/da7091ac76f622cd.png"
            },
            {
              "name": "舒适家用",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t1/95609/29/18724/14414/5e966dbdE4d4f93c7/ebe31b9cc535e122.png"
            },
            {
              "name": "轻奢小资",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t1/107135/26/12311/13191/5e966dc9Eab12bb04/517bd20b14b205d2.png"
            },
          ]
        },
        {
          "name": "汽车装饰",
          "children": [
            {
              "name": "香水",
              "image": "https://img10.360buyimg.com/focus/s140x140_jfs/t13759/326/1785480674/5074/ee5e11b5/5a28ae70N2103e1ad.jpg"
            },
            {
              "name": "功能小件",
              "image": "https://img30.360buyimg.com/focus/s140x140_jfs/t12031/185/1786124151/4188/4fbcefa1/5a28ae4aNc332a72c.jpg"
            },
            {
              "name": "挂件",
              "image": "https://img13.360buyimg.com/focus/s140x140_jfs/t14563/22/263252417/4276/1685f17/5a28ae7cN14672d9f.jpg"
            },
            {
              "name": "车贴",
              "image": "https://img14.360buyimg.com/focus/s140x140_jfs/t16231/145/125924495/8318/b0a5af3e/5a28ae6dNbf8afd0d.jpg"
            },
            {
              "name": "车钥匙扣",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t15562/128/151306023/5669/a6f309c5/5a28ae93Nbd3a7965.jpg"
            },
            {
              "name": "车衣",
              "image": "https://img12.360buyimg.com/focus/s140x140_jfs/t15379/29/278452727/7734/e1b9d130/5a28ae5aN98fe0b9b.jpg"
            },
          ]
        },
      ]
    },
    {
      "name": "京东超市"
    },
    {
      "name": "男装",
    },
    {
      "name": "男鞋"
    },
    {
      "name": "女装",
    },
    {
      "name": "女鞋",
    },
    {
      "name": "母婴童鞋"
    },
    {
      "name": "图书音像"
    },
    {
      "name": "运动户外"
    },
    {
      "name": "食品生鲜"
    },
    {
      "name": "酒水饮料"
    },
    {
      "name": "家具家装"
    },
    {
      "name": "家具厨具"
    },
    {
      "name": "箱包手袋"
    },
    {
      "name": "钟表珠宝"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            title: "VerticalTabBar 垂直TabBar",
          ),
          Expanded(
            child: DefaultTabController(
              length: data.length,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.zero,
                    width: 100,
                    color: Colors.transparent,
                    child: VerticalTabBar(
                      tabs: data.map((t) => Tab(text: t['name'],)).toList(),
                      isScrollable: true,
                      indicatorWeight: 4,
                      labelColor: Color(0xffe93b3d),
                      indicatorColor: Color(0xffe93b3d),
                      unselectedLabelColor: Color(0xff333333),
                      labelStyle: TextStyle(
                        fontSize: 14
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 14
                      ),
                    ),
                  ),
                  Expanded(
                      child: VerticalTabBarView(
                        children: data.map(
                          (v) => v['children'] != null ? Container(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: ListView(
                                padding: EdgeInsets.all(14),
                                children: List.of(v['children']).map((cate) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(cate['name'], style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.w500
                                      ),),
                                      SizedBox(height: 12,),
                                      cate['children'] != null ? Container(
                                        width: MediaQuery.of(context).size.width - 100 - 28,
                                        child: Wrap(
                                          children: List.of(cate['children']).map((item) {
                                            return Column(
                                              children: <Widget>[
                                                CachedNetworkImage(imageUrl: item['image'], width: 70, height: 70, fit: BoxFit.cover,),
                                                SizedBox(height: 4,),
                                                Container(
                                                  width: 70,
                                                  child: Text(item['name'], style: TextStyle(
                                                      fontSize: 12
                                                  ), overflow: TextOverflow.ellipsis,),
                                                  alignment: Alignment.center,
                                                )
                                              ],
                                            );
                                          }).toList(),
//                                    spacing: 3,
                                          runSpacing: 20,
                                          spacing: (MediaQuery.of(context).size.width - 100 - 28 - 210) / 2,
                                          alignment: WrapAlignment.start,
                                        ),
                                      ) : Gaps.empty,
                                      SizedBox(height: 40,)
                                    ],
                                  );
                                }).toList() ,
                              ),
                            ),
                          ) : Container(
                            color: Colors.white,
                          )
                        ).toList(),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}