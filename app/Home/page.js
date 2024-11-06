"use client";
import React, { useEffect, useState, useRef } from "react";
import { BrowserMultiFormatReader } from "@zxing/library";
import "./style.css";
import "../../app/global.css";
import Swal from "sweetalert2";
import axios from "axios";

const Home = () => {
  const [currentUser, setCurrentUser] = useState(null);
  const [scanning, setScanning] = useState(false);
  const [actionState, setActionState] = useState(null);
  const [currentUserNumber, setCurrentUserNumber] = useState("");
  const videoRef = useRef(null);
  const codeReader = useRef(null);

  const url = "http://localhost/attendance-api/main.php";

  useEffect(() => {
    const data = sessionStorage.getItem("user");
    if (data) {
      const parsedData = JSON.parse(data);
      console.log(parsedData);
      setCurrentUser(parsedData);
      setCurrentUserNumber(parsedData.student_id);
    } else {
      window.location.href = "/";
    }
  }, []);

  useEffect(() => {
    if (scanning && videoRef.current) {
      codeReader.current = new BrowserMultiFormatReader();
      codeReader.current.decodeFromVideoDevice(
        null,
        videoRef.current,
        (result, error) => {
          if (result) {
            console.log("QR Code Result:", result.text);

            const eventID = extractEventID(result.text);
            if (actionState === "timeIn") {
              timeIn(eventID);
            } else if (actionState === "timeOut") {
              timeOut(eventID);
            }
            setScanning(false);
            if (codeReader.current) {
              codeReader.current.reset();
            }
          }
          if (error) {
            console.error("QR Code Error:", error);
          }
        }
      );
    }
  }, [scanning, actionState]);

  const extractEventID = (text) => {
    const match = text.match(/Event ID: (\d+)/);
    return match ? match[1] : null;
  };

  console.log("Curretn Number", currentUserNumber);

  const timeIn = async (eventID) => {
    const formData = new FormData();
    formData.append("operation", "checkInStudent");
    formData.append(
      "json",
      JSON.stringify({
        student_id: currentUserNumber,
        event_id: eventID,
      })
    );

    try {
      const res = await axios({
        url: url,
        method: "POST",
        data: formData,
      });

      if (res.status !== 200) {
        Swal.fire("Error", `${res.statusText}`, "error");
        return;
      }

      if (res.data.success) {
        console.log(res.data);
        Swal.fire("Success", res.data.success || "Time in success", "success");
      } else {
        console.log(res.data);
        Swal.fire("Error", res.data.error || "Time in fail", "error");
      }
    } catch (e) {
      Swal.fire("Error", "An unexpected error occurred", "error");
    }
  };

  const timeOut = async (eventID) => {
    const formData = new FormData();
    formData.append("operation", "checkOutStudent");
    formData.append(
      "json",
      JSON.stringify({
        student_id: currentUser.student_id,
        event_id: eventID,
      })
    );

    try {
      const res = await axios({
        url: url,
        method: "POST",
        data: formData,
      });

      if (res.status !== 200) {
        Swal.fire("Error", `${res.statusText}`, "error");
        return;
      }

      if (res.data.success) {
        console.log(res.data);
        Swal.fire("Success", res.data.success || "Time in success", "success");
      } else {
        console.log(res.data);
        Swal.fire("Error", res.data.error || "Time in fail", "error");
      }
    } catch (e) {
      Swal.fire("Error", "An unexpected error occurred", "error");
    }
  };

  // const handleOnTimeOutScanned = (data) => {
  //   console.log("Handling Time Out Scanned Data:", data);
  //   setScanning(false);
  //   if (codeReader.current) {
  //     codeReader.current.reset();
  //   }
  // };

  const renderYearLevelTitle = () => {
    switch (currentUser?.year_level) {
      case "1":
        return "First Year";
      case "2":
        return "Second Year";
      case "3":
        return "Third Year";
      case "4":
        return "Fourth Year";
      default:
        return "Unknown Year Level";
    }
  };

  const handleLogout = () => {
    sessionStorage.removeItem("user");
    window.location.href = "/";
  };

  const handleTimeIn = () => {
    setScanning(true);
    setActionState("timeIn");
  };

  const handleTimeOut = () => {
    setScanning(true);
    setActionState("timeOut");
  };

  const isTimeInDisabled = actionState === "timeIn";
  const isTimeOutDisabled = actionState === "timeOut";

  if (!currentUser) {
    return <div>Loading...</div>;
  }

  return (
    <>
      <div className="flex items-center">
        <div className="card">
          <div
            className="banner"
          >
            <div className="student-image">
              <img src="/images/student.jpg" alt="Student Icon" />
            </div>
          </div>
          <div className="menu">
            <div className="opener" onClick={handleLogout}>
              <span></span>
              <span></span>
              <span></span>
            </div>
          </div>
          <h2 className="name">{currentUser.name}</h2>
          <div className="title">{renderYearLevelTitle()}</div>
          <div className="actions">
            <div className="follow-info">
              <h2>
                <a href="#">
                <p>Tribu</p>
                  <span>
                    {currentUser.tribu_name
                      ? currentUser.tribu_name
                      : "Not yet assigned to a tribu."}
                  </span>
                 
                </a>
              </h2>
            </div>
          </div>
        </div>

        <div className="card p-4">
          {scanning && (
            <div className="scanner">
              <video ref={videoRef} style={{ width: "100%", height: "auto" }} />
            </div>
          )}

          {currentUser.tribu_name ? (
            <div className="actions">
              <div className="follow-btn mt-8">
                <button onClick={handleTimeIn} disabled={isTimeInDisabled}>
                  Time In
                </button>
              </div>
              <div className="follow-btn mt-8">
                <button onClick={handleTimeOut} disabled={isTimeOutDisabled}>
                  Time Out
                </button>
              </div>
            </div>
          ) : (
            <p>No actions available</p>
          )}
        </div>
      </div>
    </>
  );
};

export default Home;
