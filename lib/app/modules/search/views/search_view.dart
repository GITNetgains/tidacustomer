import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tida_customer/app/components/no_data.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/modules/search/controllers/search_controller.dart';
import 'package:tida_customer/app/routes/app_pages.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';
import 'package:tida_customer/utils/custom_cards.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(builder: (c) {
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Image.asset("assets/footer.png"),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium("Search", color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                getVerticalSpace(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      c.tags!.trim().isNotEmpty
                          ? Row(
                              children: [
                                setMediumLabel("by"),
                                getHorizontalSpace(),
                                setMediumLabel(c.tags!, color: Colors.red),
                              ],
                            )
                          : Container(),
                      c.tags!.trim().isNotEmpty
                          ? getVerticalSpace()
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.74,
                            child: TextField(
                              controller: c.searchCtr,
                              onChanged: (t) async {
                                if (t.trim().isNotEmpty) {
                                  c.isSearchEmpty = false;
                                  c.isLoading = true;
                                  c.update();
                                  await c.getData(t.trim());
                                  if (c.venues!.isEmpty &&
                                      c.academies!.isEmpty &&
                                      c.tournaments!.isEmpty &&
                                      c.experiences!.isEmpty) {
                                    c.isSearchEmpty = true;
                                    c.clearLists();
                                    c.showNoData = true;
                                    c.isLoading = false;
                                    c.update();
                                  } else {
                                    //c.clearLists();
                                    c.showNoData = false;
                                    c.isLoading = false;
                                    c.update();
                                  }
                                } else {
                                  c.isSearchEmpty = true;
                                  c.clearLists();
                                  c.showNoData = true;
                                  c.isLoading = false;
                                  c.update();
                                }
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: PRIMARY_COLOR)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent)),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: PRIMARY_COLOR,
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[800]),
                                  hintText: "Search",
                                  fillColor: Colors.grey.withOpacity(0.1)),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              var result =
                                  await Get.toNamed(AppPages.FILTER_SCREEN);
                              debugPrint("FL result $result ");
                              c.tags = await MySharedPref.getfiltervenue();
                              c.radius = await MySharedPref.getradius();
                              c.update();
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.filter_list_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                basebody(
                    c.isLoading!,
                    c.showNoData!
                        ? NoData(
                            msg:
                                "Type something in search box to search nearby academies, venues, tournaments and events.",
                          )
                        : Column(
                            //shrinkWrap: true,
                            children: [
                              getVerticalSpace(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children:
                                    List.generate(c.venues!.length, (index) {
                                  return venuecard(
                                      c.venues![index]!.image.toString(),
                                      c.venues![index]!.title.toString(),
                                      c.venues![index]!.address.toString(),
                                      c.venues![index]!.id.toString());
                                }),
                              ),
                              getVerticalSpace(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(c.tournaments!.length,
                                    (index) {
                                  return tournamentcard(
                                      c.tournaments![index]!.image.toString(),
                                      c.tournaments![index]!.title.toString(),
                                      c.tournaments![index]!.description
                                          .toString(),
                                      c.tournaments![index]!.id.toString());
                                }),
                              ),
                              getVerticalSpace(),
                              Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(c.academies!.length,
                                      (index) {
                                    return academyCard(
                                        c.academies![index]!.logo.toString(),
                                        c.academies![index]!.name.toString(),
                                        c.academies![index]!.address.toString(),
                                        c.academies![index]!.id.toString());
                                  })),
                              getVerticalSpace(),
                              Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(c.experiences!.length,
                                      (index) {
                                    return experincecard(
                                        c.experiences![index]!.image.toString(),
                                        c.experiences![index]!.title.toString(),
                                        c.experiences![index]!.description
                                            .toString(),
                                        c.experiences![index]!.id.toString());
                                  })),
                              getVerticalSpace()
                            ],
                          ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
