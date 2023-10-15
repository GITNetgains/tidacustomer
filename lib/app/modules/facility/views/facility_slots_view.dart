import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tida_customer/app/data/local/my_shared_pref.dart';
import 'package:tida_customer/app/modules/facility/controllers/facility_slots_controller.dart';
import 'package:tida_customer/config/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tida_customer/utils/color_utils.dart';
import 'package:tida_customer/utils/common_utils.dart';

class FacilitySlotsView extends StatelessWidget {
  const FacilitySlotsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FacilitySlotsController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: setHeadlineMedium("Select Slot", color: Colors.white),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16).w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16).r,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 15.r,
                        color: CupertinoColors.lightBackgroundGray)
                  ]),
              child: TableCalendar(
                firstDay: DateTime.now(),
                focusedDay: c.selectedDateTime!,
                lastDay: DateTime(2100),
                headerVisible: true,
                currentDay: DateTime.now(),
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day) {
                  return isSameDay(c.selectedDateTime, day);
                },
                onDaySelected: (selectedDay, focusedDay) async {
                  debugPrint("selectedDay $selectedDay");
                  c.selectedDateTime = selectedDay;
                  c.selectedSlot = -1;
                  c.selectedDate =
                      DateFormat("yyyy-MM-dd").format(c.selectedDateTime!);
                  await c.getFacilitySlots();
                  c.update();
                },
              ),
            ),
            basebody(
                c.isLoading!,
                c.slots!.isEmpty
                    ? const Center(
                        child: Text("No Slots available for today."),
                      )
                    : SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.61,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).h,
                            child: GridView.builder(
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                ),
                                itemCount: c.slots!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.all(5).h,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        color: (c.slots![index]!.slotBlockStatus
                                                        .toString() ==
                                                    "1" ||
                                                c.slots![index]!
                                                        .slotBookingStatus
                                                        .toString() ==
                                                    "1")
                                            ? Colors.redAccent
                                            : c.selectedSlot == index
                                                ? Colors.lightGreen
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: CupertinoColors
                                                  .extraLightBackgroundGray,
                                              blurRadius: 10,
                                              offset: Offset(1, 1))
                                        ]),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(12),
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: (c.slots![index]!.slotBlockStatus
                                                        .toString() ==
                                                    "1" ||
                                                c.slots![index]!
                                                        .slotBookingStatus
                                                        .toString() ==
                                                    "1")
                                            ? () {
                                                // Get.dialog(Center(
                                                //   child: Wrap(
                                                //     children: [
                                                //       Material(
                                                //         type: MaterialType
                                                //             .transparency,
                                                //         child: Container(
                                                //             margin: EdgeInsets
                                                //                 .symmetric(
                                                //                     horizontal:
                                                //                         24),
                                                //             padding: EdgeInsets
                                                //                 .symmetric(
                                                //                     vertical:
                                                //                         16,
                                                //                     horizontal:
                                                //                         16),
                                                //             decoration: BoxDecoration(
                                                //                 borderRadius:
                                                //                     BorderRadius
                                                //                         .circular(
                                                //                             16),
                                                //                 color: Colors
                                                //                     .white),
                                                //             child: c.slots![index]!
                                                //                         .slotBookingDetail !=
                                                //                     null
                                                //                 ? Column(
                                                //                     mainAxisSize:
                                                //                         MainAxisSize
                                                //                             .min,
                                                //                     children: [
                                                //                       Row(
                                                //                         mainAxisSize:
                                                //                             MainAxisSize.max,
                                                //                         mainAxisAlignment:
                                                //                             MainAxisAlignment.center,
                                                //                         children: [
                                                //                           setCardHeading("Booked by"),
                                                //                         ],
                                                //                       ),
                                                //                       Padding(
                                                //                         padding:
                                                //                             const EdgeInsets.all(8.0),
                                                //                         child:
                                                //                             Row(
                                                //                           mainAxisSize:
                                                //                               MainAxisSize.max,
                                                //                           mainAxisAlignment:
                                                //                               MainAxisAlignment.spaceBetween,
                                                //                           children: [
                                                //                             setHeadlineMedium("Name"),
                                                //                             setMediumLabel(c.slots![index]!.user!.name.toString(), color: PRIMARY_COLOR)
                                                //                           ],
                                                //                         ),
                                                //                       ),
                                                //                       const Divider(),
                                                //                       Padding(
                                                //                         padding:
                                                //                             const EdgeInsets.all(8.0),
                                                //                         child:
                                                //                             Row(
                                                //                           mainAxisSize:
                                                //                               MainAxisSize.max,
                                                //                           mainAxisAlignment:
                                                //                               MainAxisAlignment.spaceBetween,
                                                //                           children: [
                                                //                             setHeadlineMedium("Phone"),
                                                //                             setMediumLabel(c.slots![index]!.user!.phone.toString(), color: PRIMARY_COLOR)
                                                //                           ],
                                                //                         ),
                                                //                       ),
                                                //                       const Divider(),
                                                //                       Padding(
                                                //                         padding:
                                                //                             const EdgeInsets.all(8.0),
                                                //                         child:
                                                //                             Row(
                                                //                           mainAxisSize:
                                                //                               MainAxisSize.max,
                                                //                           mainAxisAlignment:
                                                //                               MainAxisAlignment.spaceBetween,
                                                //                           children: [
                                                //                             setHeadlineMedium("email"),
                                                //                             setMediumLabel(c.slots![index]!.user!.email.toString(), color: PRIMARY_COLOR)
                                                //                           ],
                                                //                         ),
                                                //                       ),
                                                //                       const Divider(),
                                                //                       Padding(
                                                //                         padding:
                                                //                             const EdgeInsets.all(8.0),
                                                //                         child:
                                                //                             Row(
                                                //                           mainAxisSize:
                                                //                               MainAxisSize.max,
                                                //                           mainAxisAlignment:
                                                //                               MainAxisAlignment.spaceBetween,
                                                //                           children: [
                                                //                             setHeadlineMedium("Booking status"),
                                                //                             setMediumLabel(c.slots![index]!.slotBookingDetail!.bookingStatus.toString(), color: PRIMARY_COLOR)
                                                //                           ],
                                                //                         ),
                                                //                       ),
                                                //                       const Divider(),
                                                //                       Padding(
                                                //                         padding:
                                                //                             const EdgeInsets.all(8.0),
                                                //                         child:
                                                //                             Row(
                                                //                           mainAxisSize:
                                                //                               MainAxisSize.max,
                                                //                           mainAxisAlignment:
                                                //                               MainAxisAlignment.spaceBetween,
                                                //                           children: [
                                                //                             setHeadlineMedium("email"),
                                                //                             setMediumLabel(c.slots![index]!.user!.email.toString(), color: PRIMARY_COLOR)
                                                //                           ],
                                                //                         ),
                                                //                       )
                                                //                     ],
                                                //                   )
                                                //                 : Container(
                                                //                     height:
                                                //                         150,
                                                //                     child:
                                                //                         Center(
                                                //                       child: Text(
                                                //                           "No Info available"),
                                                //                     ),
                                                //                   )),
                                                //       )
                                                //     ],
                                                //   ),
                                                // ));
                                              }
                                            : () {
                                                c.selectedSlot = index;
                                                c.facilityId = c
                                                    .slots![index]!.facility_id
                                                    .toString();
                                                c.update();
                                              },
                                        child: Container(
                                          //color: Colors.white,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  setSmallLabel(getFormattedTime(
                                                          "${DateFormat("yyyy-MM-dd").format(c.selectedDateTime!)} ${c.slots![index]!.slotStartTime!}")
                                                      .toString()),
                                                  getVerticalSpace(),
                                                  setSmallLabel(getFormattedTime(
                                                          "${DateFormat("yyyy-MM-dd").format(c.selectedDateTime!)} ${c.slots![index]!.slotEndTime!}")
                                                      .toString()),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      )),
            // getVerticalSpace(),
            // getVerticalSpace(),
            // getVerticalSpace(),
            // getVerticalSpace(),
            // getVerticalSpace(),
            // getVerticalSpace()
          ],
        ),
        floatingActionButton: c.selectedSlot != -1
            ? Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: c.isBooking!
                          ? const SizedBox(
                              height: 50,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          : MySharedPref.getemail() == "guest@email.com"
                              ? getSecondaryButton('Book Now', () {
                                  customerlogin();
                                })
                              : getSecondaryButton("₹${c.amt} Book Slot", () {
                                  c.isBooking = true;
                                  c.isLoading = true;
                                  c.update();
                                  c.bookFacilitySlot(
                                      c.slots![c.selectedSlot]!.slotStartTime
                                          .toString(),
                                      c.slots![c.selectedSlot]!.slotEndTime
                                          .toString(),
                                      c.facilityId);
                                }),
                    )
                  ],
                ),
              )
            : Container(),
        // Center(
        //   child: c.bookingService!=null ? BookingCalendar(
        //   bookingService: c.bookingService!,
        //     convertStreamResultToDateTimeRanges: c.convertStreamResult,
        //     getBookingStream: c.getBookingStream,
        //     uploadBooking: c.uploadBooking,
        //     //pauseSlots: generatePauseSlots(),//pauseSlotText: 'LUNCH',  //hideBreakTime: false,
        //     loadingWidget: const Text('Fetching data...'),
        //     uploadingWidget: const CircularProgressIndicator(),
        //     locale: 'en',
        //     startingDayOfWeek: StartingDayOfWeek.monday,

        //     wholeDayIsBookedWidget:
        //         const Text('Sorry, for this day everything is booked'),
        //     //disabledDates: [DateTime(2023, 1, 20)],
        //     //disabledDays: [6, 7],
        //   ):Container(),
      );
    });
  }
}
