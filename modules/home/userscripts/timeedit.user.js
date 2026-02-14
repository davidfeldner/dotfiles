// ==UserScript==
// @name        Autumn2025-timeedit.net
// @namespace   Violentmonkey Scripts
// @match       https://cloud.timeedit.net/itu/web/public/ri11X95X26X8W5Q549Q351Y7Z85Y85W95Yg89595YY9X2X3XZ1Q5xlQQY10Xup8y0u95Z5XY00Q5l9XxZ965YQY55c7ZZ1110963g549645205Q0YgX69.html*
// @grant       none
// @version     1.0
// @author      -
// @description 9/1/2025, 3:06:05 PM
// ==/UserScript==
(function () {
  "use strict";

  function fixSchedule() {
    // Find all divs with class "timeDiv"
    const timeDivs = document.querySelectorAll("div.bookingDiv");

    timeDivs.forEach((div) => {
      if (div.textContent.includes("SWU 2nd year, Study Lab")) {
        const parent = div.parentElement.parentElement;
        if (
          parent &&
          parent.querySelector("span.daytext").textContent.trim() == "Thursday"
        ) {
          div.style.setProperty("opacity", "20%");
        }
      }
      if (
        (div.textContent.includes("Programmer som data") &&
          div.textContent.includes("Lecture")) ||
        div.textContent.includes("1st year, Study Lab") ||
        (div.textContent.includes("Algorithm Design") &&
          div.textContent.includes("Extra TA sessions"))
      ) {
        const parent = div.parentElement.parentElement;
        if (parent) {
          div.style.setProperty("opacity", "50%");
        }
      }
      if (div.textContent.includes("Programmer som data")) {
        const parent = div.parentElement.parentElement;
        if (
          parent &&
          parent.querySelector("span.daytext").textContent.trim() == "Tuesday"
        ) {
          div.style.setProperty("opacity", "50%");
        }
      }
      if (div.textContent.includes("Algorithm Design, KSALDES1KU")) {
        div.style.setProperty("background-color", "#e0a86b", "important");
      } else if (div.textContent.includes("Advanced Programming")) {
        div.style.setProperty("background-color", "#98f9f6", "important");
      } else if (div.textContent.includes("Machine Learning")) {
        div.style.setProperty("background-color", "#f9a7f5", "important");
      } else if (
        div.textContent.includes(
          "Practical Concurrent and Parallel Programming",
        )
      ) {
        div.style.setProperty("background-color", "#c7f99a", "important");
      } else if (
        div.textContent.includes("Study Lab") &&
        div.textContent.includes("SWU 2nd year")
      ) {
        div.style.setProperty("background-color", "#f98181", "important");
      }
    });
  }

  fixSchedule();
})();
