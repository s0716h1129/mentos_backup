package com.study.android.mentos_project;


import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.ArrayList;

public class BeaconClassAdapter extends RecyclerView.Adapter<BeaconClassAdapter.ClassItemViewHolder> {
    public interface ItemClick {
        public void onClick(View view, int position);
    }
    private ItemClick itemClick;

    public void setItemClick(ItemClick itemClick) {
        this.itemClick = itemClick;
    }

    Context context;
    ArrayList<ClassJoin> items = new ArrayList<>();

    public class ClassItemViewHolder extends RecyclerView.ViewHolder {
        protected TextView tv1;
        protected TextView tv2;
        protected TextView tv4;
        protected TextView tv5;
        protected TextView tv6;
        protected LinearLayout itemLayout;

        public ClassItemViewHolder(View view) {
            super(view);
            tv1 = view.findViewById(R.id.tvIClassName);
            tv2 = view.findViewById(R.id.tvIClassMento);tv4 = view.findViewById(R.id.tvIDate);
            tv5 = view.findViewById(R.id.tvITime);
            tv6 = view.findViewById(R.id.tvIPlace);
            itemLayout = view.findViewById(R.id.classItemLayout);
        }
    }

    public BeaconClassAdapter(Context context) {
        this.context = context;
    }

    public void addItem(ClassJoin item) {
        items.add(item);
    }

    @Override
    public ClassItemViewHolder onCreateViewHolder (ViewGroup viewGroup, int viewType) {
        View view = LayoutInflater.from(viewGroup.getContext())
                .inflate(R.layout.class_item_view, viewGroup, false);

        ClassItemViewHolder viewHolder = new ClassItemViewHolder(view);

        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull ClassItemViewHolder viewHolder, int position) {
        viewHolder.tv1.setText(items.get(position).getClass_name());
        viewHolder.tv2.setText("(강사 : " + items.get(position).getClass_mento() + " )");
        viewHolder.tv4.setText("강의 기간 : " + items.get(position).getClass_startdate() + " ~ " + items.get(position).getClass_enddate());
        viewHolder.tv5.setText("진행 시간 : " + items.get(position).getClass_starttime() + " ~ " + items.get(position).getClass_endtime());
        viewHolder.tv6.setText(items.get(position).getClass_place());

        final int num = position;

        viewHolder.itemLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (itemClick != null) {
                    itemClick.onClick(v, num);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return (null != items ? items.size() : 0);
    }

    public Object getItem(int position) {
        return items.get(position);
    }

}
