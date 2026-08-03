class TicketStatisticsModel {
  final int totalTickets;
  final int openTickets;
  final int inProgressTickets;
  final int closedTickets;

  const TicketStatisticsModel({
    required this.totalTickets,
    required this.openTickets,
    required this.inProgressTickets,
    required this.closedTickets,
  });

  factory TicketStatisticsModel.empty() {
    return const TicketStatisticsModel(
      totalTickets: 0,
      openTickets: 0,
      inProgressTickets: 0,
      closedTickets: 0,
    );
  }

  TicketStatisticsModel copyWith({
    int? totalTickets,
    int? openTickets,
    int? inProgressTickets,
    int? closedTickets,
  }) {
    return TicketStatisticsModel(
      totalTickets: totalTickets ?? this.totalTickets,
      openTickets: openTickets ?? this.openTickets,
      inProgressTickets: inProgressTickets ?? this.inProgressTickets,
      closedTickets: closedTickets ?? this.closedTickets,
    );
  }
}
