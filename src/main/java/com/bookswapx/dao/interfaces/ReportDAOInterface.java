package com.bookswapx.dao.interfaces;

import com.bookswapx.model.Report;
import java.util.List;

public interface ReportDAOInterface {
	boolean fileReport(Report report);

	List<Report> getAllPendingReports();

	boolean updateReportStatus(int reportId, String status);
}