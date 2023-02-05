//
//  RoutesView.swift
//  GPP
//
//  Created by Saša Marjanović on 01.02.2023..
//

import SwiftUI

struct RoutesView: View {
    
    @State var query: String = ""
    
    @EnvironmentObject var busStopData: BusStopData

    var groupedFoundRoutes: Array<(String, [Route])>{
        return self.groupRoutesByNumber(routes: busStopData.routes).filter{ (key, values) in
            return values[0].number.lowercased().contains(query.lowercased())
            || values[0].destination.lowercased().contains(query.lowercased())
            || values[1].number.lowercased().contains(query.lowercased())
            || values[1].destination.lowercased().contains(query.lowercased())
        }
    }
    
    func groupRoutesByNumber(routes: [Route]) -> Array<(String,[Route])> {
        var groupedRoutes = [String: [Route]]()
        for route in routes {
            if groupedRoutes[route.number] == nil {
                groupedRoutes[route.number] = [route]
            } else {
                groupedRoutes[route.number]?.append(route)
            }
        }
        return groupedRoutes.sorted(by: { $0.key < $1.key })
    }
    
    var body: some View {
        
        NavigationView{

            VStack{
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.title2)
                    TextField("Potrazi liniju ili odrediste", text: $query)
                        .textFieldStyle(.roundedBorder)
                }.padding(EdgeInsets(top: 18, leading: 18, bottom: 5, trailing: 18))
                
                HStack{
                    Text("LINIJA")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 18))
                    Text("ODREDISTA")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                    Spacer()
                }
                .padding(EdgeInsets(top: 18, leading: 18, bottom: 0, trailing: 18))

                if query != "" {
                    List(groupedFoundRoutes ,id: \.0) { (key: String, values: [Route]) in
                        NavigationLink(destination: RouteView(route: values.first!)){
                            HStack{
                                Text(key)
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 38))
                                Text(values.first?.destination ?? "")
                                    .font(.title2)
                                Image(systemName: "arrow.right.arrow.left")
                                    .foregroundColor(.blue)
                                    .font(.body)
                                Text(values.count > 1 ? values[1].destination : "")
                                    .font(.title2)
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                    }
                    .listStyle(.plain)
                    .frame(alignment: .leading)
                }
                else {
                    List(groupRoutesByNumber(routes: busStopData.routes),id: \.0) { (key: String, values: [Route]) in
                        NavigationLink(destination: RouteView(route: values.first!)){
                            HStack{
                                Text(key)
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 38))
                                Text(values.first?.destination ?? "")
                                    .font(.title2)
                                Image(systemName: "arrow.right.arrow.left")
                                    .foregroundColor(.blue)
                                    .font(.body)
                                Text(values.count > 1 ? values[1].destination : "")
                                    .font(.title2)
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                    }
                    .listStyle(.plain)
                    .frame(alignment: .leading)
                }
                
                Spacer()
            }
            .navigationBarTitle(Text("Linije"),displayMode: .inline)
        }
    }
}

struct RoutesView_Previews: PreviewProvider {
    static var previews: some View {
        RoutesView()
            .environmentObject(BusStopData())
    }
}
