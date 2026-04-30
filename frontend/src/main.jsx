import React from "react";
import ReactDOM from "react-dom/client";
import { ConfigProvider } from "antd";
import { AppRouter } from "./app/router.jsx";
import "./styles/global.css";

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <ConfigProvider
      theme={{
        token: {
          colorPrimary: "#1565c0",
          borderRadius: 6
        }
      }}
    >
      <AppRouter />
    </ConfigProvider>
  </React.StrictMode>
);
